Return-Path: <dmaengine+bounces-8523-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFWcFdgyeGlRowEAu9opvQ
	(envelope-from <dmaengine+bounces-8523-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:36:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BB38FA51
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CFB301905A
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B402620FC;
	Tue, 27 Jan 2026 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jrEegMB1"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC730DD29;
	Tue, 27 Jan 2026 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484893; cv=fail; b=uPGrkwJA56lPsxxJA8aez8oTZbJK9tyqVfVMX0J81ILtd0D5eGvCgP5UOuxDlKLg7rpnaNlYLNApZ0ctrxUrBfSVk7JzOl4YY9GCW7VXiwM7c3wrSDMp+rWjSRm1GgCf7V5imrIOBDI2HBDUDgNLdqkxv8DqBwdHqZBZerLvEG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484893; c=relaxed/simple;
	bh=4MlGDzQ5ukL39L3sdVNFKpnu/K/OeBoQJPga0XsYri4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YaA9EQf2tlq7SevSjWqJQuUTxNjtcIpyWCYk6WR6J1XHhuyTTlKnsDvSPMc89pV3gxexOdSVdeWsQgovXhlg5wJt0zyfKIz7CpW7glRv226HH7qfLW2PSISSO5sbMi9jcVikrS/hhrCBgbeqLMhsZu3fpqoE0prbeYxFxLakl7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jrEegMB1; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVfzWrU7Wg28RoJlMVuFKT4RVRBubMXJx1okOl0mWAHvUR21bDxBeq93WzMgvdsgcBAMTcEB1CDol4k3EchLgcqLp2NBdWQ6AGcgsTbt9XR4E7QZNKWOrCDpUlp/HJHqDO2Zjdq5/m8QGr4bnLyqBM56EGA9SgmP+Cf1xqMIKe53fv1cSUNctkNCOhCfIT8tSKGauI9jLQh5SR3Cw0JM7v8FwGViHGKkk/FZs6L0Zy993bcUUNYnGAfRCx0oBlYKBmMf+uCLPbaKjarmHu1HRXpWX3J3obcMks4GdyRFC48QUn5m1FdgtN9YN2OtcqfRYijjgZ/Xluc+sP9x9s4mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7r6f6anFEM8ibuM9Qd4/hNUAIVpt14ASjYOk37W8bU=;
 b=gMlfbE2XFbP94VLaAC9IXq24MhTRWmJrTkgRq0Byl+yad27uaomrY8FBz6mGleQAPWcY7FO4/K2wpkgPIYRrl8gDM9J4yuhl/gL6jA/N/P3Jijxz/S4G7l2I+ViN89KbMsZSSW7g16OUEAqhaKNepWsy+dG97XuLr+IP7qGHkZThcdsl15IrFt7Cf4zJAGXt3zwoxmaaDCwxkOZ5OP04cMKE8R8Rp+dbnpmRrnvCix/nUzciGh2gg6pzybfc59w6HHE20r8cMX7GYNyJw8Jqdz8rOJvD6n7h4vxlu+68Gd6kOR9UfK6CHflf8royXEAmR9OUqXqv6vtH6KZ/zBQMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7r6f6anFEM8ibuM9Qd4/hNUAIVpt14ASjYOk37W8bU=;
 b=jrEegMB11vfbccrz8DxAKapTrXrAJQtWOTsc+bvaRUnaipDwavtwaOaY0Rg3PoyOinqJkLugKHQKNv596mz3fjBV36AID4Y9phnGMWdeFDVgChymQF7xS4/qoPDxdXxnQu0B2Xt7go2yYnLAq+V3ZBQ2U0yYtdpwQL49dAEuYpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5626.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:34:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:34:45 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] dmaengine: dw-edma: Add notify-only channels support
Date: Tue, 27 Jan 2026 12:34:18 +0900
Message-ID: <20260127033420.3460579-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127033420.3460579-1-den@valinux.co.jp>
References: <20260127033420.3460579-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0061.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: a34a3361-0f5e-4a02-4368-08de5d5503bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UsioeTT9xUkk8DJ5sKgXnIiHc7zxyxQLeVwxOAySAf7KKiUprgIAhBH2rw+H?=
 =?us-ascii?Q?pDOzLNAX3Nz/91Z/yHTyt5fxSITCo+m+nXlJb8eL6njZ034WGI2PBwFriM8G?=
 =?us-ascii?Q?45cmyy1RRKl7GmnFLjoJ5Gor77CPQuQ6w4xbdPggRXTc/wiUec3ZwKYluuij?=
 =?us-ascii?Q?2lr3tCLY36GFY8nNG4EZPSXpii54SkonmvCjSxy3rUrZzKxhSr7qdCzI9K5K?=
 =?us-ascii?Q?f7ZZRUPqjqFzSCC/KWuvj3R9iqOyZ8oC5AtdNH+CvT6p4js8dAmvhvHafsrl?=
 =?us-ascii?Q?8SqDPtqOQ2uffAmMYOUTfQIcglCCPC/CcVWo/y6wQqleJgBDFb9rK5GFZsAB?=
 =?us-ascii?Q?wMpr2lwqjp1fK0+pp/hvQuRu0UAVWHGnvwIUztn7VOsf1mh8ktanopaI6DPS?=
 =?us-ascii?Q?UhNdHfQkqmdMjiTLSV+rWw8ZaX6B4/JiBO9XDh1KzTCfDMiX1yCdgBlalse7?=
 =?us-ascii?Q?vHqPYJOwgIq8P57LIhSETfCfJoljiNShS4141Qci/fJBLoWVMAhWOaczOXIO?=
 =?us-ascii?Q?E3vyrsXwwKYgVEK30Df+ZMRYJZ+BWVNRYGMC17qrt12vQDA4xWU2nLqeGvWr?=
 =?us-ascii?Q?++lEA14ko90S9xOP0O/8E4+Z35X4npo+yAjlfIwIJHUGYtbk0KDj9ihbaD7M?=
 =?us-ascii?Q?L0omGUyv3mYoDzKZZ1LEKqh/9EE8nc8QLs2joDaJj64n8mz15beGLuW7Nxkx?=
 =?us-ascii?Q?njVr4uH1n8G0XHrYYBg57FMms2T6lGmy4vJxJWzEFTyBCttOR5sT5qM84OfB?=
 =?us-ascii?Q?MisHevNdKuaRiI0HSQtxzJHvZ6sBDEMEs7Aonz818OUsC/9g21UTBkfZrIkb?=
 =?us-ascii?Q?0e1RV/G9omxbg651RRlkrN07PwHlpqsGtc2FT4tjLkP8FuHJG2fgfReNTco8?=
 =?us-ascii?Q?3JFI0ZAstDTYxKy1P2R2M9fuHmJ83aoEouPd87zRPHEsDT3QnsVNuM0kc7Ig?=
 =?us-ascii?Q?TBHmmrcZZ+UOalv4faJenEUjKo9/2bSJ+znURQRmAcKPdZY1IX09IFSIFSEH?=
 =?us-ascii?Q?H2vvuqOCkstl5deo7AMk25FG4W1VnLEXtllshy5SUHTpCSq3lem9US/reQxz?=
 =?us-ascii?Q?fY+/w57zg77unm+gBJX/31LDHhPmGhzB5fLB+0DVAx8/KhS6YH0hlkHHtloV?=
 =?us-ascii?Q?FYqzZdzAdStyLFbj9YT7U71ugBanf5qW2Y33h9FUTdte1apgT9OqxDpfvBCg?=
 =?us-ascii?Q?GlXwjUWCs9wX65+e7X2U/GQ8rp29GRTJX72vxJXjp89K2jjbx9ylP/Z5K/nj?=
 =?us-ascii?Q?8yjDlv8mcTlx3g+vchzu3rq1d1g/Kka6fG6cJ/FhAmD4L+/xOMKJ0y/g/M/8?=
 =?us-ascii?Q?IbNAaHjMVIEFOCPPWZGgs4LJIkHOdEgGRQbafmyFGbtjcnh3xUx3qtHuyx1J?=
 =?us-ascii?Q?+5boVXT/avQOmnpeeFGdwZPvfka/DHc/U5wxoVf0kZLCCH/oLUJn1zehCupS?=
 =?us-ascii?Q?cbyyjLd1gk++onvlizGvE5SQyauPhSsq0jgiSN72lfUFJN6b8vHZVUd8VVcW?=
 =?us-ascii?Q?3zUCI5WwJGnJF2qg/aquVDTvvisZk7SpEJq+FS6FLbzlLJsKxJ93pCovYQV6?=
 =?us-ascii?Q?drYFeDuWo4oKY2FJlxw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zm8rqQGstRZNcvKyPDj2VEfVUHhTjTWQr4J6zFrG+rGQXUG3URsSvgUx84T?=
 =?us-ascii?Q?Hb8tcQ5MCtnguZu9SVnvGP6Zv97QezyrWFdGPb5bj9j8F9K+rJ13vmg036fF?=
 =?us-ascii?Q?Q3Oq2i97BzcBx1Y1apJHXjAhUGG8OCoimNVXB81KuVxfm1pnYawPhcJNMm9Q?=
 =?us-ascii?Q?07GuaxA8w/7Pux1EKjeIKwt0PIR3YVSZkSDkBmer2ee7X8mk5t2HURyEeQTg?=
 =?us-ascii?Q?SjtKROdZYdzmA/s5uqwnNlh3axoD7NYOSvh94nE8mb5S0vIyg/FBhkKFgDd+?=
 =?us-ascii?Q?abcTH+8Ux/n8EfIvc1V08u8gwFY89QyFOBrhCUSY3xLWjhmu1Zgcz9oilIQN?=
 =?us-ascii?Q?NUsWtmi+cEk2QhB+LQ/YQ3hH1wMJsfvf7Vg1sJ+dDZ77ZU5nZJTmT4Yf4sVB?=
 =?us-ascii?Q?9ubWdM4+3Q2e4w+Fb3sTjH8MG8N50CZ902kM72keindIbI8c//j+YPypXVD5?=
 =?us-ascii?Q?aG+6KwYCBj07Wc8WVwVQkNihP8QSZTGoVUUMPm6wKn3nraUMo9bYYG9kv+J6?=
 =?us-ascii?Q?88cXaGDpsclt30F6TngnH+IPk2lVjf7tdFJWKZ17a3FV5l35BrHRP789f/DR?=
 =?us-ascii?Q?2ccfvNyvRlOBhpkxifjAxhu+/rz+SFGI0y523BSGzPrgnuZIEGZgtbNc4Abl?=
 =?us-ascii?Q?fONCDyJLL6QyS20WChIya7hfSVAaSLfhn9xeMsahNIpBHB1uRCNJ5t7gphVR?=
 =?us-ascii?Q?j6GIANnZ29rLQs4tJ1A4yh1jUrjwnQSG0+iyeBlU0aycrxJraNbkXFmGel+t?=
 =?us-ascii?Q?KuRJM4LANRr6U5kOQ7IIHfbDm2Yj8M+KT76+yqpRzIeR5YnfaRklrsUB/rp0?=
 =?us-ascii?Q?nEDy2OfgnqO9Cq1IImkfWyQrbB17ZTfsJ7WcwKmFAtOtVq93OTipyGAAT0H1?=
 =?us-ascii?Q?ocz6R9JrN6KuAxUWP0Ok0HNGxJyi5CgadOXfS/HAAlzOkT68tcwjhANkYi9q?=
 =?us-ascii?Q?FET3Oy8zJXO3+8pVG1luj1HaWl8ITMrguSvOvYt4S+wQOtjWHT7/tMAJupYY?=
 =?us-ascii?Q?Xm+M2MRSO4XE2MtKo48Ou4NgjL+u2czsCQuhIyzzc8UnmJcq9hyMX8hScgES?=
 =?us-ascii?Q?mmkKq809hQQHT36qPEESFTnLJn3eHfrnMffkQI5hxxri1vymFA5gx+OytCU2?=
 =?us-ascii?Q?1mZLSERUbnMx3SGGvUZ1NDGpFousetP81s0T3Wv8bGl91WENJicMEtwpo5GE?=
 =?us-ascii?Q?xM+Z98VNJTKtfA3dM2DFWZQ7qrNgKT967PpXOBlQIay1DUkw3BvhHUoFmY7W?=
 =?us-ascii?Q?WDlyoapkf9b9cJ9MwRtY7FVP6SBloIDwReHHPF6bUpHeXNMJcqOZ6ZcNAUvM?=
 =?us-ascii?Q?P4cxHjop5Dn45Amwolz2Z2oIEwaz6v7x7scRvJt8r5VQz+hMvqy2BRHgQ0+c?=
 =?us-ascii?Q?VdV6IlPwd153Ty2WLtE5jHZDkqgQ3t18FnyEvwi/aH0r5+/6Vlh1eA0d/K6I?=
 =?us-ascii?Q?EyeFCLfBAvMMv2rAo/KpAPHmt3ye2rTzb36X5h8iVUB14o7jj77jpr9KmbKu?=
 =?us-ascii?Q?sv8EvyPI6Y8pv7H62BFYvTllllUX3LtPc0m2nE7drprWR+OoX4OjWtGcPpDL?=
 =?us-ascii?Q?wYdlG0QWoe1NVy+VzPOvbXCsIalJLiCakFe1LADiUmuQqv0SLfKzbXcajyXP?=
 =?us-ascii?Q?z0bi3ktSeda5Jk4qx6ZBLn3z3YToUJzKjn/OY12oUmJhrXGyZqABL73knAe9?=
 =?us-ascii?Q?91+TrqIVzbau7EFZEdEqhTIMZaNZf9Se/TsJfMibO6y3h9eQLTD3Bv/wRBwp?=
 =?us-ascii?Q?jEnYXzMZRSm6JRk+UoEXbvKUbvw/naUkjrqqNt8SwAw9Tqab3gcq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a34a3361-0f5e-4a02-4368-08de5d5503bf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:34:45.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3afTF6J4IiGbU1WHw6q4igzUyH9KlYcNvWIi+FJvb53LkmkZquPvazlFAg2mGyvLeEQBwAfCqZ54uvMYUXqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5626
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8523-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,synopsys.com:email]
X-Rspamd-Queue-Id: E7BB38FA51
X-Rspamd-Action: no action

Remote eDMA users may want to prepare descriptors on the remote side while
the local side only needs completion notifications.

Provide a lightweight per-channel notification callback infrastructure.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 41 ++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h |  4 +++
 include/linux/dma/edma.h           | 29 +++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 910a4d516c3a..3396849d0606 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -616,6 +616,13 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 
+	if (chan->notify_only) {
+		if (chan->notify_cb)
+			chan->notify_cb(&chan->vc.chan, chan->notify_cb_param);
+		/* no cookie on this side, just return */
+		return;
+	}
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
@@ -834,6 +841,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
 		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
+		chan->notify_cb = NULL;
+		chan->notify_cb_param = NULL;
+		chan->notify_only = false;
 
 		spin_lock_init(&chan->poll_lock);
 		INIT_DELAYED_WORK(&chan->poll_work, dw_edma_poll_work);
@@ -1115,6 +1125,37 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+int dw_edma_chan_register_notify(struct dma_chan *dchan,
+				 void (*cb)(struct dma_chan *chan, void *data),
+				 void *data)
+{
+	struct dw_edma_chan *chan;
+
+	if (!dchan || !dchan->device ||
+	    dchan->device->device_config != dw_edma_device_config)
+		return -ENODEV;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	/*
+	 * Reject the operation while the channel is active or has queued
+	 * descriptors.
+	 */
+	scoped_guard(spinlock_irqsave, &chan->vc.lock) {
+		if (chan->request != EDMA_REQ_NONE ||
+		    chan->status != EDMA_ST_IDLE ||
+		    !list_empty(&chan->vc.desc_submitted) ||
+		    !list_empty(&chan->vc.desc_issued))
+			return -EBUSY;
+	}
+
+	chan->notify_cb = cb;
+	chan->notify_cb_param = data;
+	chan->notify_only = !!cb;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 560a2d2fea86..d5ee8330a6cb 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -84,6 +84,10 @@ struct dw_edma_chan {
 
 	enum dw_edma_ch_irq_mode	irq_mode;
 
+	void (*notify_cb)(struct dma_chan *chan, void *data);
+	void *notify_cb_param;
+	bool notify_only;
+
 	struct delayed_work		poll_work;
 	spinlock_t			poll_lock;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 16e9adc60eb8..35275576f273 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -133,6 +133,27 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+
+/**
+ * dw_edma_chan_register_notify - register completion notification callback
+ * @chan: DMA channel obtained from dma_request_channel()
+ * @cb:   callback invoked when a completion is detected on @chan (NULL to
+ *        unregister)
+ * @data: opaque pointer passed back to @cb
+ *
+ * This is a lightweight notification mechanism intended for channels whose
+ * descriptors are managed externally (e.g. remote eDMA). When enabled, the
+ * local dw-edma instance does not perform cookie accounting for completions,
+ * because the corresponding descriptor is not tracked locally.
+ *
+ * The callback may be invoked from atomic context and must not sleep.
+ *
+ * Return: 0 on success, -ENODEV if @chan is not a dw-edma channel,
+ *         -EBUSY if the channel is active or has queued descriptors.
+ */
+int dw_edma_chan_register_notify(struct dma_chan *chan,
+				 void (*cb)(struct dma_chan *chan, void *data),
+				 void *data);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -143,6 +164,14 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
+					       void (*cb)(struct dma_chan *chan,
+							  void *data),
+					       void *data)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0


