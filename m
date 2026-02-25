Return-Path: <dmaengine+bounces-9108-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIbLG85sn2mObwQAu9opvQ
	(envelope-from <dmaengine+bounces-9108-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:42:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A919DED8
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 002D1307AFEE
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96753176E0;
	Wed, 25 Feb 2026 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AiJeRYnG"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4D3161AB;
	Wed, 25 Feb 2026 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055731; cv=fail; b=PFiGk0DUNnIDJ+JgoNOQn/4mqMo/cP2YRTwoZkf3KCRNznsyIWVqm5tx5zvKCxgTpDQAsu7TRvHE14BS4qA6czM7wCx5a1QByp6u4TDdlDik2XVdZCE5CM0HICgLlzPodSAlht87i1mVZA451uWQe1PbTCDLE1yzkeJ9ZKkpCDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055731; c=relaxed/simple;
	bh=g+Y0kY1GUqXgi/3GMJ9DzqVrhe8erSxFdVfZszyxO2Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AYw2pU9b6VnYCWfgdKoJYmVKVw4KIzgwQUr5Au4/s89S5AtLu0D5jkHtM8t7Xb4s4Vy2Ucv508/7NH6jQ7Eloj3MXrTbG+w3b6AHujK2ODftWoQ81JL5AhjeBxnOeZqVY3888TAjRRFoIsO8HpMjXDNUlt8auEAM8dXDlgUGXlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AiJeRYnG; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gn9siI541SD7Zg/xTp3Um55JhfS7nV4IFrEFlVNwIH9BrQXoEbPTUQhZNaaKKr1xhfTgrJ3eeRiEWFKcvxi7hkYxj4sDq7brDOg0f1zvK5cKBhxq8qeZzZ7damRzkdlGFj8bZsCh7gijxffY9plsTS58qQbrbJbIZf2BzfQ0DVL2O9R0gBBX5ruilOoVLjj4KvTTqlF/9n3VcUQGDElCtAaqXffYZY71kuRDZsXbGMmhAoA/cxy0BQLj8wfL6PTm0zFHhByjeXpSRjwh4l4i0DRumcBnIu6KkNOpYY3m245RrShi5ipR+mTjd+zmO4zqK34FktmWKrNQx05c8ARhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zElMqM5T8In/dJ771CcPYQecnth56Iizp6TAzkyo79c=;
 b=jVHtPUCBR3hkH8xG/hH85eWMX89U5ezcK0bFpJKENA1QBDwxTNJbUB9tR99gW1hRdoJ+y4m/8Kz5K53uSjiBRTB+psDM+RK7o2/EKaFOsFDGadrkMsZ7fmU+JQ5Q69gSbvM1FUU9JFBozDTqJLVoropMFPQvoBf6WfH+7fMF+iSkVEajGMuAyBkyQtHpS99b51uj++bjegzaNkf/U2w4/321+sev9On8mOGo5t10Xi1aZ4v+0TZEh6iiUBq/WwEXgVQ0HoWStI2so9E6t6LNUvz300K28l4nPdNWh6aIdjDMVUhKuOaO5yaMFgYEn6Tl/m15EtEvL0IKOcaY78f1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zElMqM5T8In/dJ771CcPYQecnth56Iizp6TAzkyo79c=;
 b=AiJeRYnGYHSrI0GxOZ55H4F8RbQhMV/Uu1m35/vWpVxkat3BX7VGkWk9TI7m/F5HpeM2wW3xEvKy+0jNr1BPIBuBG379HGCn4ebVc7nBRKuvNMzZGQ5Vu6pl0NSwAWkK0oEMAaFTpfAAqHaeDn0QNLmVPTMB6aw1nYLMkajsOW8n9MskmNBi/s/Du46WaB13BrFFS5Mb71uwFGqIGFjT107c03wgZMTTWj4JuJdH6ZellNmozaR8d+wRURkt+9UZQ2e6r9aLvrYiyhtlPOC1N3j7/OzCSuzQOaVeoWDmto2z6KDHN5d9QtgDmnijoqka4yDTepKMdzdzofOVrFdxFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:40 -0500
Subject: [PATCH v3 04/13] dmaengine: mxs-dma: Use dev_err_probe() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-4-8f798b13baa6@nxp.com>
References: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
In-Reply-To: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=1547;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=g+Y0kY1GUqXgi/3GMJ9DzqVrhe8erSxFdVfZszyxO2Y=;
 b=1+tRSROeNecnxxwkXCiAofpwJh4tFW7Lwhr2nRrnwiym9qazYFSCKFsuszNOL9PFm+Eehtqdg
 8qLDaaRvC56DjHrQbUsMvWFM2Jxr9PQLI5mjye7KpZ3n2GY0EfBmU0k
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b276fe-0a75-4ed3-6293-08de74b6b7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	4lNPfyxkeIBLMfvLD0n6lMjHKmYtWCq4SO7KcONcSS7GabkqgVZYgVhODfGhMpWSkbuA4vNtu8eeT8hcC5enLWMDIG2mxTEo8RMv9o6+OpZ8pguUSaVCf4XMhj72nwKITlTPDXMyLHa64w2FME/Ru9qXbCpczNPS+nPv5EUnItjijcqLnVkc/ASpxKs5/WAsq3Ku6N8PC19uwvKhSHgPXmwoczauwK57O/YHYTf0O7QnSUY8FD08N+g7Wk6+8gZ3TNvQAO9qk7kpfpWcFpj0v/cRaGCUV+fxnuKv5S8RWHP6TxroJy4LDG2TN+Sz8Pra1eVVmcYHLIfo9etdjCKdu+3BYQoomzp4enOu0SbLbyfw3okqIbLihfWzGMqZrPZSrnYMxcRUqCW9Tk3gO7FXEs8nBfyKt9or1tpZcvv/NaiipyjvI7q4xAkm7xFB2g4llGe2O4Ux33Ip+cDNY3ALLbaaVNzasP2N/niMoh8ekzkt0K+gUsk7I4CkMx6LJWi67+GfJnMxJ7GInLGtMjjRtqCkHtieczu6zeJYtM5z3bmUQ3P2iE4q36TG3PNJP3T2r6ACw9n56mAmCvtBhzSFzHhaKnosTKJGvU1tKyXFloUTzGaW+SdUrnVrJzK4lzMG1twG4Xbmbw7Yl+NwOW6Ta1/D5VkIJfOoQqV/LS8VW5kSVCVLLnhzQTT0JdOuhuJvShU6LXuhbajYQjesSQyPSjOKt9XqdDIKy/jNDp9ejqfgHblL5VQAe9+8cEmdAhEz5tUZPKcIaMBoQv3Uk5FD+Yyj/9xCPRppb/UfmY6DMX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2hwamVxd3VobCsyTWZOM3JQdWRETS9RSWhPd214VGlLWTc3NG4zREIzcU1a?=
 =?utf-8?B?VmxVVzkyb3Q0L205T2ZyZDhEWDhkdXhvVXZuSjdOWmlPd2s5MkhBMm51MGl1?=
 =?utf-8?B?dU9mWStIZktXUlRCY2hIdlBvcUkxUFFIczVrSjRaZG0wRmorbTVLRVIrYzVO?=
 =?utf-8?B?b0FyZUtpeTU3QjhHeU14TndscDk4YjV0blZraG9uUmI2UUUvRVpST0hORXNE?=
 =?utf-8?B?dEExYnE2a0FrRWxsWlg4b1JSQVViT3dFUW5ubnV3SUFQNzlNZVN6NkpIbTdo?=
 =?utf-8?B?a2dDa2IrNnNqWnh1S2ZCcW1QM2NLOU1uM3BUamtVbURzbGZyYnJuaFN6MkJB?=
 =?utf-8?B?TDJiREc1Ni9MS1FMRU5tYUl0eTBEVW1NZXl5SStHKzZUK0crSERxTWtwV28v?=
 =?utf-8?B?Ymx3SG8veTh0c1dlZVdpbXkwUlhVWEo1NmdkTDFEMUprMmlldVpKb3Q1akl1?=
 =?utf-8?B?Z1FXN3hQeTdkOFlzcmJVbXhra3d0QUQwTWhiSWE3RHZUbXkzbUN3WkQwdUtG?=
 =?utf-8?B?V0cwL0VWL2ZXL1BEZ3IxdzVWTlBmUWRoekhPLzZxM3BRNFQ2T2hNYUZQR1dC?=
 =?utf-8?B?SStqVVpXSnVIaEpySHAwc0F0RUhNUFFNU2xnS2s0ZXhEVEhmT2tjdnlvNUNy?=
 =?utf-8?B?MkNHNEJvNlpQNm1MSjk5ZFF2aTJOejhhTUlkNGlmdXpHNXFLenlpZlFRWW9r?=
 =?utf-8?B?K3NoZUx2UzdVWjVLRzJVVkpQSXQrc2QrdGlVTm1DQzlENC9qYjcyTmZTemZL?=
 =?utf-8?B?elN1aDBQVlNFVU1WTEJOZEdubWFGTkRYcERQQVVBM2JHcWJ5TmVDMGVJR0Nq?=
 =?utf-8?B?YUFad3VNMlladmU0Vk1OQWJMQ1hpaGdmMEJDU016dkQwdStLV3pNY1gwK2ls?=
 =?utf-8?B?Wnd4S0xXN0wzUlF5YlV5NnFrN3UwWjU3SkxzM010ZVowaUtCZTFLUldGVG1s?=
 =?utf-8?B?WVcrUDZiMnNlUHp5cW1DL2l4UzVtM3pmbk10UEtzYWVwNXo3M2hDMXVZZVBa?=
 =?utf-8?B?bkViQlFVc0pudENaeVRqd281RThQV00xbXFaUHpweStvUmlSZnhEOWdvKzht?=
 =?utf-8?B?OVFzMFRoekNoU0FhRlJlZVN6KzR3MTJHSUxBT3daa2R6aFVQbUpaalZTVC94?=
 =?utf-8?B?cys5Ly91QVd0YVpQc2c0WkRoVlNNVVpjWlRMYWRhY2NDWlg0bzRpMjQ0Z3I0?=
 =?utf-8?B?QWtmNEFwNWh5Zm1VNmtFdnRzSUl4aHdFOGttSHBrcGNpRDNlZmMzYS9pMlpl?=
 =?utf-8?B?QUNUTEhyRjB3VVRRNEdDN0Z1UW4xNHdVODhBNGlEdHp0SXlRdkQxYzZsdVp0?=
 =?utf-8?B?SzcrWE9vemhYenJtcTZpNWo4aExXcWhKd004RHBoakQ0dXdvc2J3RnEwYkRm?=
 =?utf-8?B?bVhqdU82Z1BuOHhJbmIvQU8va3RBMUh0QzlyOHY0RGx4QUQ2QmpTV3VuazFy?=
 =?utf-8?B?blRScUtJOXBqU09hOTNsSTh1N0djWmhhZ0pDWnQybTZZM1RGd3M1YTN3YzFN?=
 =?utf-8?B?ZGo4VnVUcU54aFY2MlpiOWJJTFZ3cnQ1TDM2bWFJdHhUYVJtUGMxN25zdklJ?=
 =?utf-8?B?YmZ0cUlJSXp6OHppRFZtMXVodEl2azlWdnh1anBKODdPYi80VCtUU3RqeGx0?=
 =?utf-8?B?eXhFaGFZYVZpV3AxcmZQTUQ4WUx6TWpKemF5L0RPd2dyOTM2QzVzbzhpNnRX?=
 =?utf-8?B?MW5hMWhlc3FhRWtOYmhWeVd3NEk1TTdnclVzT3IvdWlTSXJTaXBON1diVnRK?=
 =?utf-8?B?bGZNZnZSU3hVVzB1ckNyeGdRQTI2VkhWK2F6dzhFM3JkSE4zUTJJS0VVTjFZ?=
 =?utf-8?B?WitESnh4OTkyd1FaWGUxQ2RSaFhjSGRwQ0t2UUVIYUp5U1cwN29URHBzWWlx?=
 =?utf-8?B?WGhxaHZIVTZabDhKOFBtR21Ec3JhdXdEbmxsMUJ0TmhRbGNmQXpqZnUwRDNK?=
 =?utf-8?B?RFBpdzBUYTAvTWxrWjR2aktMVHFrMHQzV29Yd2dDb2ZmR0wrSTlSQnEvWmJE?=
 =?utf-8?B?dmtocWdxMVF3M1VNRlphc3NLaEYzSTA2a0hOVERubjhWZlpEMzBvUDlQOHow?=
 =?utf-8?B?UmNBYnpsMjQ1Y3RoY1h5YnNOOE96ZDhybVlWaFQxeWNWaWVYT2Y5d0lvU2NK?=
 =?utf-8?B?bEhrU09MamxzV25hLzVUNFEramZvL2Yxb0R5SVlIMTRLcWNIL05xRkxLM3Nq?=
 =?utf-8?B?UmVGMnFFYnBlK0gzNUtiQkM5YXBhRUEwS0YwMzQvZGIzNkpQNElsTEU5eTJQ?=
 =?utf-8?B?Y2kyVDFlcHJ6VWIrNU9MWnR1ZHM0N1pPdDM4VnFBS3Y2YnRaT3F4QnlIV0lr?=
 =?utf-8?B?VjJURktyNlFRb1pTMjFBRG4xYU5FY3I3NHlDaWg1OUlXeUxRZjNkZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b276fe-0a75-4ed3-6293-08de74b6b7ef
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:05.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JakBDXQbnhoHsh6YAxU2rJd7PsG/d/hiEROWNVAEMrsEiukF4zrADTkG0S098dNyA+jg0kNOqrcwed/o82lcDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9108-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 276A919DED8
X-Rspamd-Action: no action

Use dev_err_probe() simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 5340f831ae9dbf5423564e070735f5289c8d49de..e05bca738d2efe45d385dfb2180dd1c75b00163e 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -753,10 +753,8 @@ static int mxs_dma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "dma-channels", &mxs_dma->nr_channels);
-	if (ret) {
-		dev_err(dev, "failed to read dma-channels\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read dma-channels\n");
 
 	dma_type = (struct mxs_dma_type *)of_device_get_match_data(dev);
 	mxs_dma->type = dma_type->type;
@@ -816,17 +814,13 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->dma_device.device_issue_pending = mxs_dma_enable_chan;
 
 	ret = dmaenginem_async_device_register(&mxs_dma->dma_device);
-	if (ret) {
-		dev_err(dev, "unable to register\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to register\n");
 
 	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
-	if (ret) {
-		dev_err(dev,
-			"failed to register controller\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register controller\n");
 
 	dev_info(dev, "initialized\n");
 

-- 
2.43.0


