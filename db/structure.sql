SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: application_bundles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.application_bundles (
    id bigint NOT NULL,
    application_id bigint,
    bundle_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: application_bundles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.application_bundles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: application_bundles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.application_bundles_id_seq OWNED BY public.application_bundles.id;


--
-- Name: application_instances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.application_instances (
    id bigint NOT NULL,
    application_id bigint,
    lti_key character varying,
    lti_secret character varying,
    encrypted_canvas_token character varying,
    encrypted_canvas_token_salt character varying,
    encrypted_canvas_token_iv character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    domain character varying(2048),
    site_id bigint,
    tenant character varying,
    config jsonb DEFAULT '{}'::jsonb,
    lti_config jsonb,
    disabled_at timestamp without time zone,
    bundle_instance_id bigint,
    anonymous boolean DEFAULT false,
    rollbar_enabled boolean DEFAULT true,
    use_scoped_developer_key boolean DEFAULT false NOT NULL
);


--
-- Name: application_instances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.application_instances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: application_instances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.application_instances_id_seq OWNED BY public.application_instances.id;


--
-- Name: applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.applications (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    client_application_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    kind bigint DEFAULT 0,
    application_instances_count bigint,
    default_config jsonb DEFAULT '{}'::jsonb,
    lti_config jsonb,
    canvas_api_permissions jsonb DEFAULT '{}'::jsonb,
    key character varying,
    oauth_precedence character varying DEFAULT 'global,user,application_instance,course'::character varying,
    anonymous boolean DEFAULT false,
    lti_advantage_config jsonb DEFAULT '{}'::jsonb,
    rollbar_enabled boolean DEFAULT true,
    oauth_scopes character varying[] DEFAULT '{}'::character varying[],
    oauth_key character varying,
    oauth_secret character varying
);


--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authentications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentications (
    id bigint NOT NULL,
    user_id bigint,
    provider character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uid character varying,
    provider_avatar character varying,
    username character varying,
    provider_url character varying(2048),
    encrypted_token character varying,
    encrypted_token_salt character varying,
    encrypted_token_iv character varying,
    encrypted_secret character varying,
    encrypted_secret_salt character varying,
    encrypted_secret_iv character varying,
    encrypted_refresh_token character varying,
    encrypted_refresh_token_salt character varying,
    encrypted_refresh_token_iv character varying,
    id_token character varying,
    lti_user_id character varying,
    application_instance_id bigint,
    canvas_course_id bigint
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.authentications_id_seq OWNED BY public.authentications.id;


--
-- Name: bundle_instances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bundle_instances (
    id bigint NOT NULL,
    site_id bigint,
    bundle_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    entity_key character varying,
    id_token character varying
);


--
-- Name: bundle_instances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bundle_instances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bundle_instances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bundle_instances_id_seq OWNED BY public.bundle_instances.id;


--
-- Name: bundles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bundles (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    key character varying,
    shared_tenant boolean DEFAULT false
);


--
-- Name: bundles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bundles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bundles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bundles_id_seq OWNED BY public.bundles.id;


--
-- Name: canvas_courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.canvas_courses (
    id bigint NOT NULL,
    lms_course_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: canvas_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.canvas_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: canvas_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.canvas_courses_id_seq OWNED BY public.canvas_courses.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    id bigint NOT NULL
);


--
-- Name: ims_exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ims_exports (
    id integer NOT NULL,
    token character varying,
    tool_consumer_instance_guid character varying,
    context_id character varying,
    custom_canvas_course_id character varying,
    payload jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying DEFAULT 'processing'::character varying,
    message character varying(2048)
);


--
-- Name: ims_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ims_exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ims_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ims_exports_id_seq OWNED BY public.ims_exports.id;


--
-- Name: ims_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ims_imports (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying NOT NULL,
    error_message character varying,
    error_trace text,
    export_token character varying,
    context_id character varying NOT NULL,
    tci_guid character varying NOT NULL,
    lms_course_id character varying NOT NULL,
    source_context_id character varying NOT NULL,
    source_tci_guid character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    payload jsonb
);


--
-- Name: ims_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ims_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ims_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ims_imports_id_seq OWNED BY public.ims_imports.id;


--
-- Name: jwks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jwks (
    id bigint NOT NULL,
    kid character varying,
    pem character varying,
    application_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: jwks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jwks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jwks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jwks_id_seq OWNED BY public.jwks.id;


--
-- Name: lti_deployments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lti_deployments (
    id bigint NOT NULL,
    application_instance_id bigint,
    deployment_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    lti_install_id bigint
);


--
-- Name: lti_deployments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lti_deployments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lti_deployments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lti_deployments_id_seq OWNED BY public.lti_deployments.id;


--
-- Name: lti_installs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lti_installs (
    id bigint NOT NULL,
    iss character varying,
    application_id bigint,
    client_id character varying,
    jwks_url character varying,
    token_url character varying,
    oidc_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: lti_installs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lti_installs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lti_installs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lti_installs_id_seq OWNED BY public.lti_installs.id;


--
-- Name: lti_launches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lti_launches (
    id bigint NOT NULL,
    config jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    token character varying,
    context_id character varying,
    tool_consumer_instance_guid character varying
);


--
-- Name: lti_launches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lti_launches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lti_launches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lti_launches_id_seq OWNED BY public.lti_launches.id;


--
-- Name: nonces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.nonces (
    id bigint NOT NULL,
    nonce character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: nonces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.nonces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nonces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.nonces_id_seq OWNED BY public.nonces.id;


--
-- Name: oauth_states; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_states (
    id bigint NOT NULL,
    state character varying,
    payload text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: oauth_states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_states_id_seq OWNED BY public.oauth_states.id;


--
-- Name: open_id_states; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.open_id_states (
    id bigint NOT NULL,
    nonce character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: open_id_states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.open_id_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: open_id_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.open_id_states_id_seq OWNED BY public.open_id_states.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    role_id bigint,
    user_id bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    context_id character varying
);


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: que_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.que_jobs (
    priority smallint DEFAULT 100 NOT NULL,
    run_at timestamp without time zone DEFAULT now() NOT NULL,
    job_id bigint NOT NULL,
    job_class text NOT NULL,
    args json DEFAULT '[]'::json NOT NULL,
    error_count integer DEFAULT 0 NOT NULL,
    last_error text,
    queue text DEFAULT ''::text NOT NULL
);


--
-- Name: TABLE que_jobs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.que_jobs IS '3';


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.que_jobs_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.que_jobs_job_id_seq OWNED BY public.que_jobs.job_id;


--
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_questions (
    id bigint NOT NULL,
    quiz_id bigint,
    quiz_group_id bigint,
    assessment_question_id bigint,
    question_data text,
    assessment_question_version integer,
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    migration_id character varying,
    workflow_state character varying,
    duplicate_index integer,
    root_account_id bigint
);


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quizzes (
    id bigint NOT NULL,
    title character varying,
    description text,
    quiz_data text,
    points_possible double precision,
    context_id bigint NOT NULL,
    context_type character varying NOT NULL,
    assignment_id bigint,
    workflow_state character varying NOT NULL,
    shuffle_answers boolean DEFAULT false NOT NULL,
    show_correct_answers boolean DEFAULT true NOT NULL,
    time_limit integer,
    allowed_attempts integer,
    scoring_policy character varying,
    quiz_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    lock_at timestamp without time zone,
    unlock_at timestamp without time zone,
    deleted_at timestamp without time zone,
    could_be_locked boolean DEFAULT false NOT NULL,
    cloned_item_id bigint,
    access_code character varying,
    migration_id character varying,
    unpublished_question_count integer DEFAULT 0,
    due_at timestamp without time zone,
    question_count integer,
    last_assignment_id bigint,
    published_at timestamp without time zone,
    last_edited_at timestamp without time zone,
    anonymous_submissions boolean DEFAULT false NOT NULL,
    assignment_group_id bigint,
    hide_results character varying,
    ip_filter character varying,
    require_lockdown_browser boolean DEFAULT false NOT NULL,
    require_lockdown_browser_for_results boolean DEFAULT false NOT NULL,
    one_question_at_a_time boolean DEFAULT false NOT NULL,
    cant_go_back boolean DEFAULT false NOT NULL,
    show_correct_answers_at timestamp without time zone,
    hide_correct_answers_at timestamp without time zone,
    require_lockdown_browser_monitor boolean DEFAULT false NOT NULL,
    lockdown_browser_monitor_data text,
    only_visible_to_overrides boolean DEFAULT false NOT NULL,
    one_time_results boolean DEFAULT false NOT NULL,
    show_correct_answers_last_attempt boolean DEFAULT false NOT NULL,
    root_account_id bigint,
    disable_timer_autosubmission boolean DEFAULT false NOT NULL
);


--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- Name: request_statistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.request_statistics (
    truncated_time timestamp without time zone NOT NULL,
    tenant character varying NOT NULL,
    number_of_hits integer DEFAULT 1,
    number_of_lti_launches integer DEFAULT 0,
    number_of_errors integer DEFAULT 0
);


--
-- Name: request_user_statistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.request_user_statistics (
    truncated_time timestamp without time zone NOT NULL,
    tenant character varying NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sites (
    id bigint NOT NULL,
    url character varying(2048),
    oauth_key character varying,
    oauth_secret character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    secret character varying
);


--
-- Name: sites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sites_id_seq OWNED BY public.sites.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count bigint DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    password_salt character varying,
    lti_user_id character varying,
    lti_provider character varying,
    lms_user_id character varying,
    create_method bigint DEFAULT 0,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id bigint,
    invitations_count integer DEFAULT 0
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_bundles ALTER COLUMN id SET DEFAULT nextval('public.application_bundles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_instances ALTER COLUMN id SET DEFAULT nextval('public.application_instances_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentications ALTER COLUMN id SET DEFAULT nextval('public.authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bundle_instances ALTER COLUMN id SET DEFAULT nextval('public.bundle_instances_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bundles ALTER COLUMN id SET DEFAULT nextval('public.bundles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_courses ALTER COLUMN id SET DEFAULT nextval('public.canvas_courses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_exports ALTER COLUMN id SET DEFAULT nextval('public.ims_exports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_imports ALTER COLUMN id SET DEFAULT nextval('public.ims_imports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jwks ALTER COLUMN id SET DEFAULT nextval('public.jwks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_deployments ALTER COLUMN id SET DEFAULT nextval('public.lti_deployments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_installs ALTER COLUMN id SET DEFAULT nextval('public.lti_installs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_launches ALTER COLUMN id SET DEFAULT nextval('public.lti_launches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nonces ALTER COLUMN id SET DEFAULT nextval('public.nonces_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_states ALTER COLUMN id SET DEFAULT nextval('public.oauth_states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.open_id_states ALTER COLUMN id SET DEFAULT nextval('public.open_id_states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: job_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_jobs ALTER COLUMN job_id SET DEFAULT nextval('public.que_jobs_job_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: application_bundles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_bundles
    ADD CONSTRAINT application_bundles_pkey PRIMARY KEY (id);


--
-- Name: application_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_instances
    ADD CONSTRAINT application_instances_pkey PRIMARY KEY (id);


--
-- Name: applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: bundle_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bundle_instances
    ADD CONSTRAINT bundle_instances_pkey PRIMARY KEY (id);


--
-- Name: bundles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bundles
    ADD CONSTRAINT bundles_pkey PRIMARY KEY (id);


--
-- Name: canvas_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_courses
    ADD CONSTRAINT canvas_courses_pkey PRIMARY KEY (id);


--
-- Name: courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: ims_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_exports
    ADD CONSTRAINT ims_exports_pkey PRIMARY KEY (id);


--
-- Name: ims_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_imports
    ADD CONSTRAINT ims_imports_pkey PRIMARY KEY (id);


--
-- Name: jwks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jwks
    ADD CONSTRAINT jwks_pkey PRIMARY KEY (id);


--
-- Name: lti_deployments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_deployments
    ADD CONSTRAINT lti_deployments_pkey PRIMARY KEY (id);


--
-- Name: lti_installs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_installs
    ADD CONSTRAINT lti_installs_pkey PRIMARY KEY (id);


--
-- Name: lti_launches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_launches
    ADD CONSTRAINT lti_launches_pkey PRIMARY KEY (id);


--
-- Name: nonces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nonces
    ADD CONSTRAINT nonces_pkey PRIMARY KEY (id);


--
-- Name: oauth_states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_states
    ADD CONSTRAINT oauth_states_pkey PRIMARY KEY (id);


--
-- Name: open_id_states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.open_id_states
    ADD CONSTRAINT open_id_states_pkey PRIMARY KEY (id);


--
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: que_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_jobs
    ADD CONSTRAINT que_jobs_pkey PRIMARY KEY (queue, priority, run_at, job_id);


--
-- Name: quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: request_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_statistics
    ADD CONSTRAINT request_statistics_pkey PRIMARY KEY (truncated_time, tenant);


--
-- Name: request_user_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_user_statistics
    ADD CONSTRAINT request_user_statistics_pkey PRIMARY KEY (truncated_time, tenant, user_id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_application_bundles_on_application_id_and_bundle_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_bundles_on_application_id_and_bundle_id ON public.application_bundles USING btree (application_id, bundle_id);


--
-- Name: index_application_instances_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_instances_on_application_id ON public.application_instances USING btree (application_id);


--
-- Name: index_application_instances_on_lti_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_instances_on_lti_key ON public.application_instances USING btree (lti_key);


--
-- Name: index_application_instances_on_site_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_instances_on_site_id ON public.application_instances USING btree (site_id);


--
-- Name: index_applications_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_applications_on_key ON public.applications USING btree (key);


--
-- Name: index_authentications_on_lti_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authentications_on_lti_user_id ON public.authentications USING btree (lti_user_id);


--
-- Name: index_authentications_on_provider_and_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authentications_on_provider_and_uid ON public.authentications USING btree (provider, uid);


--
-- Name: index_authentications_on_uid_and_provider_and_provider_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authentications_on_uid_and_provider_and_provider_url ON public.authentications USING btree (uid, provider, provider_url);


--
-- Name: index_authentications_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authentications_on_user_id ON public.authentications USING btree (user_id);


--
-- Name: index_bundle_instances_on_id_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bundle_instances_on_id_token ON public.bundle_instances USING btree (id_token);


--
-- Name: index_bundles_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bundles_on_key ON public.bundles USING btree (key);


--
-- Name: index_canvas_courses_on_lms_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_canvas_courses_on_lms_course_id ON public.canvas_courses USING btree (lms_course_id);


--
-- Name: index_ims_exports_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ims_exports_on_token ON public.ims_exports USING btree (token);


--
-- Name: index_jwks_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jwks_on_application_id ON public.jwks USING btree (application_id);


--
-- Name: index_jwks_on_kid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jwks_on_kid ON public.jwks USING btree (kid);


--
-- Name: index_lti_deployments_on_application_instance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_deployments_on_application_instance_id ON public.lti_deployments USING btree (application_instance_id);


--
-- Name: index_lti_deployments_on_d_id_and_ai_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lti_deployments_on_d_id_and_ai_id ON public.lti_deployments USING btree (deployment_id, application_instance_id);


--
-- Name: index_lti_deployments_on_deployment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_deployments_on_deployment_id ON public.lti_deployments USING btree (deployment_id);


--
-- Name: index_lti_deployments_on_lti_install_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_deployments_on_lti_install_id ON public.lti_deployments USING btree (lti_install_id);


--
-- Name: index_lti_installs_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_installs_on_application_id ON public.lti_installs USING btree (application_id);


--
-- Name: index_lti_installs_on_application_id_and_iss; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_installs_on_application_id_and_iss ON public.lti_installs USING btree (application_id, iss);


--
-- Name: index_lti_installs_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_installs_on_client_id ON public.lti_installs USING btree (client_id);


--
-- Name: index_lti_installs_on_client_id_and_iss; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lti_installs_on_client_id_and_iss ON public.lti_installs USING btree (client_id, iss);


--
-- Name: index_lti_installs_on_iss; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_installs_on_iss ON public.lti_installs USING btree (iss);


--
-- Name: index_lti_launches_on_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_launches_on_context_id ON public.lti_launches USING btree (context_id);


--
-- Name: index_lti_launches_on_token_and_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lti_launches_on_token_and_context_id ON public.lti_launches USING btree (token, context_id);


--
-- Name: index_nonces_on_nonce; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_nonces_on_nonce ON public.nonces USING btree (nonce);


--
-- Name: index_oauth_states_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_states_on_state ON public.oauth_states USING btree (state);


--
-- Name: index_open_id_states_on_nonce; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_open_id_states_on_nonce ON public.open_id_states USING btree (nonce);


--
-- Name: index_permissions_on_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_permissions_on_context_id ON public.permissions USING btree (context_id);


--
-- Name: index_permissions_on_role_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_permissions_on_role_id_and_user_id ON public.permissions USING btree (role_id, user_id) WHERE (context_id IS NULL);


--
-- Name: index_permissions_on_role_id_and_user_id_and_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_permissions_on_role_id_and_user_id_and_context_id ON public.permissions USING btree (role_id, user_id, context_id);


--
-- Name: index_quiz_questions_on_quiz_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quiz_questions_on_quiz_id ON public.quiz_questions USING btree (quiz_id);


--
-- Name: index_sites_on_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sites_on_url ON public.sites USING btree (url);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON public.users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invitations_count ON public.users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_id ON public.users USING btree (invited_by_id);


--
-- Name: index_users_on_invited_by_type_and_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_type_and_invited_by_id ON public.users USING btree (invited_by_type, invited_by_id);


--
-- Name: index_users_on_lms_user_id_and_lti_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_lms_user_id_and_lti_user_id ON public.users USING btree (lms_user_id, lti_user_id);


--
-- Name: index_users_on_lti_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_lti_user_id ON public.users USING btree (lti_user_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: fk_rails_d5b56eb24a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_deployments
    ADD CONSTRAINT fk_rails_d5b56eb24a FOREIGN KEY (lti_install_id) REFERENCES public.lti_installs(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20120209004849'),
('20161026230713'),
('20161027182508'),
('20170105051107'),
('20170111234331'),
('20170113211333'),
('20170114001933'),
('20170120234606'),
('20170125022543'),
('20170206172615'),
('20170309132554'),
('20170406181303'),
('20170419195150'),
('20170420011243'),
('20170420164409'),
('20170420222813'),
('20170420222855'),
('20170421220319'),
('20170428214611'),
('20170503011153'),
('20170523025529'),
('20170612172246'),
('20170613231518'),
('20170627142629'),
('20170629220739'),
('20170705132718'),
('20170706192404'),
('20170711215536'),
('20170731160737'),
('20170807171059'),
('20170808145111'),
('20170915142046'),
('20170920214732'),
('20170921201330'),
('20170921202325'),
('20170926191503'),
('20170926200235'),
('20171003155408'),
('20171003181935'),
('20171117203730'),
('20171206054757'),
('20180201222026'),
('20180201235220'),
('20180209234904'),
('20180426214200'),
('20180522201717'),
('20181127204956'),
('20190219201006'),
('20190313033308'),
('20190319205918'),
('20190320012453'),
('20190320233646'),
('20190518190335'),
('20190523160910'),
('20190603162353'),
('20190627223838'),
('20190627224209'),
('20190708174519'),
('20190725201716'),
('20190801201027'),
('20190911015015'),
('20200125223051'),
('20200127230659'),
('20200219210631'),
('20200226194920'),
('20200624153201'),
('20200914195556'),
('20201217183552'),
('20201218171531'),
('20210115052042');


