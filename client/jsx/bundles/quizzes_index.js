/*
 * Copyright (C) 2011 - present Instructure, Inc.
 *
 * This file is part of Canvas.
 *
 * Canvas is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation, version 3 of the License.
 *
 * Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Affero General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// import I18n from 'i18n!quizzes_index'
import $ from 'jquery'
import _ from 'lodash'
import Backbone from 'Backbone'
import I18n from '../../mocks/i18n'
import QuizItemGroupView from '../../coffeescripts/views/quizzes/QuizItemGroupView'
import NoQuizzesView from '../../coffeescripts/views/quizzes/NoQuizzesView'
import IndexView from '../../coffeescripts/views/quizzes/IndexView'
import QuizCollection from '../../coffeescripts/collections/QuizCollection'
import '../../coffeescripts/handlebars_helpers'
// import QuizOverrideLoader from 'compiled/models/QuizOverrideLoader'
// import vddTooltip from 'compiled/util/vddTooltip'
// disabling for now
// import {monitorLtiMessages} from 'lti/messages'

const QuizzesIndexRouter = Backbone.Router.extend({
  routes: {
    '': 'index'
  },

  translations: {
    assignmentQuizzes: I18n.t('headers.assignment_quizzes', 'Assignment Quizzes'),
    practiceQuizzes: I18n.t('headers.practice_quizzes', 'Practice Quizzes'),
    surveys: I18n.t('headers.surveys', 'Surveys'),
    toggleMessage: I18n.t('toggle_message', 'toggle quiz visibility')
  },

  initialize() {
    this.allQuizzes = ENV.QUIZZES

    this.quizzes = {
      assignment: this.createQuizItemGroupView(
        this.allQuizzes.assignment,
        this.translations.assignmentQuizzes,
        'assignment'
      ),
      open: this.createQuizItemGroupView(
        this.allQuizzes.open,
        this.translations.practiceQuizzes,
        'open'
      ),
      surveys: this.createQuizItemGroupView(
        this.allQuizzes.surveys,
        this.translations.surveys,
        'surveys'
      ),
      noQuizzes: new NoQuizzesView()
    }
  },

  index() {
    this.view = new IndexView({
      assignmentView: this.quizzes.assignment,
      openView: this.quizzes.open,
      surveyView: this.quizzes.surveys,
      noQuizzesView: this.quizzes.noQuizzes,
      permissions: ENV.PERMISSIONS,
      flags: ENV.FLAGS,
      urls: ENV.URLS
    })
    this.view.render()
    if (this.shouldLoadOverrides()) this.loadOverrides()
  },

  loadOverrides() {
    const newQuizzes = []
    const classicQuizzes = []
    const quizTypes = ['assignment', 'open', 'surveys']
    quizTypes.forEach(quizType => {
      this.quizzes[quizType].collection.models.forEach(model => {
        if (model.attributes.quiz_type === 'quizzes.next') {
          newQuizzes.push(model)
        } else {
          classicQuizzes.push(model)
        }
      })
    })

    QuizOverrideLoader.loadQuizOverrides(newQuizzes, ENV.URLS.new_quizzes_assignment_overrides)
    return QuizOverrideLoader.loadQuizOverrides(classicQuizzes, ENV.URLS.assignment_overrides)
  },

  createQuizItemGroupView(collection, title, type) {
    const {options} = this.allQuizzes

    // get quiz attributes from root container and add options
    return new QuizItemGroupView({
      collection: new QuizCollection(_.map(collection, quiz => $.extend(quiz, options[quiz.id]))),
      isSurvey: type === 'surveys',
      listId: `${type}-quizzes`,
      title,
      toggleMessage: this.translations.toggleMessage
    })
  },

  shouldLoadOverrides() {
    return false
    // disabling for now
    return true
  }
})

// Start up the page
const router = new QuizzesIndexRouter()
Backbone.history.start()

// disabling for now
// vddTooltip()
// monitorLtiMessages()
