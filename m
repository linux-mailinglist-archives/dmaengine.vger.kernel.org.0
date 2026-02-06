Return-Path: <dmaengine+bounces-8802-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CcjHJpAhmmFLQQAu9opvQ
	(envelope-from <dmaengine+bounces-8802-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:27:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE9102B7E
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ADA530523C8
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D33302CBA;
	Fri,  6 Feb 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BrLDZijc"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7554414;
	Fri,  6 Feb 2026 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405671; cv=fail; b=VSD6hjihz88Bx2qXumAn2y+Svo8KzmFBsmXyniXfEtXZmNYyBkJZbRKUsAcAsA/zfp3sIfuPNK8oRcIKaLu6ITZUeg3uXYNXD1hCoZ25scn4a4oDNhQ44P9Uk89Ivgx+Wv/vUlA8c62oWETBBq2ZUO6fhj3PhTTd1sLTyLZ5OWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405671; c=relaxed/simple;
	bh=ucC6zeasK8FMk2awj1XKLqo9Ee8DADxwLLYH6APax6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F7ivW/cQA7Hm9aZXceeegdOV+awiYuik9/PylCJIAL9nYFCoCo/Jw/KQhhzyFWCIi/BBRjecXiTng2JrnyZcxiIxE1vd2GSIxc8ISe7zLGut4agEuBNRVLQF3SAzKyTmCmMLX2Vc5mdcR2XmFzCAkkMSpTt8Z22/SYENJlxG0ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BrLDZijc; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9JEKnCNMWvfqaO/kUD0W8De7F6D372/26iZN6pZ+nm2E7OBZf+Yu9iY9iSqA3u5KfdC2kcWhXCF4qv8kpoFYh90+0O0JBq6hkC5obr5GW3Or384mP5G/xef6fTf+OcqvvT/dDpdqSW+Z6V7gPoTgWyhKbLwdd3qdZieNsUgqQA8wIqEJMlyfCS76YGhvu9hWUqNInN/iRwUTQsTMezaftIit+W1RSO2Sp8sAUF7glyppPibWdAwZfqbjGquakdylmxY/kD3159NRt/MEx73h6ecvG+NPr5EksWR839WJmzpfqHb/yH8QRk73xaSa2mrOjBvGTsFENEJBet8fELOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny/Jt2+WJqpgPK0bCgtd8jsQ9BCBHRGUM9y5buVJzSE=;
 b=pYtdiDFRvErWdfodFy5Fi2Jj84IJEZjusoefGLXVSTcMIpxoMO0LYXo1RugwuPTUTWCoHKw+XLUJF+WPwGAU/379SLnWo0RYGIu8jHdu93Qn7yNfKXkzVoOGvzS+IkkQRpChPkEgPmzcVAkUZlTAuHN9FiyFSzG6Wohv5avWEPoCWC6RV7J8P6F1VKqDQPZPUuahqP/5ANtFWIvjWRhmSnsZ2PLTQbEs/miW0pLWfQ7WaiRJ+6DSFH5DTdGDZWrWKRijZXCKP4fRr0mljyxVB64QmAkg9QJh8sZzpWhHf23+nws4TgRxGiE1cIS8/CYLi2zL8CvZhWkkhUBpFrsbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny/Jt2+WJqpgPK0bCgtd8jsQ9BCBHRGUM9y5buVJzSE=;
 b=BrLDZijcaeqlJIHavmxYJjU59StaFe4rk7swz4tenfAxoA0AgstAZCGiBb6DYT+1zA8WHCC2it2nn34bTAD/UqoqOytayqBMW+cj/dwV3W4/ram3NsI8RMIcOYDxXzaT054aQhDU+6or74DnxgLACZmd3aQ1CPfCUPD1CwFtviDQaaZliT0cKJ7PszFeLgJCagoOpJ+gOLE2DcBrBGA63wDHU9AqtbIXs4iehQfnLtDXXhnnz8pCpakqb3A/thujpm1X6gxsYiWpyjOW69fQKQoCuJfhaQ8LYfghYSkx5YBs20swJjqVRMgv4OWfXtFkYwz5Af9tihmxnSA24o1LJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10402.eurprd04.prod.outlook.com (2603:10a6:10:55b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 19:21:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 19:21:07 +0000
Date: Fri, 6 Feb 2026 14:20:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] PCI: endpoint: pci-epf-test: Add embedded
 doorbell variant
Message-ID: <aYY_Ghig9wvnp8Wg@lizhi-Precision-Tower-5810>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172646.1556847-8-den@valinux.co.jp>
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10402:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf9aeb8-93a3-4630-35fe-08de65b4e069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/JNOQLHyQT0daxXdSEjMJz8eg1F7nNG/3sbirxq6fiBAJ7oBhNLxmLE9oRcv?=
 =?us-ascii?Q?PgFBdpoko+CrqwnhJ+SZd9Zez19ZrSeDaLYl6l0klAoSe2OojOZW2sK1fjuZ?=
 =?us-ascii?Q?bLPP90j6x2IpFKgsF5Tow0Mcxc7vTOtxK8/Mi7cS1xQkWRciwBoWoJwq1YJV?=
 =?us-ascii?Q?0GUs8QjOwoDLpEwu7zq2dDS1PRifEEebr+bwI9siAWBIb0q3k8DXgs9OUg7a?=
 =?us-ascii?Q?8Gy0h9nJnQwqfvGS2AskfhhZDL4+pAJLjNZzMBI1qj9JsSa1pG2NdZzLDCct?=
 =?us-ascii?Q?eauJGTIftQ8nQQ2MBGLuZa6QFjhNanCQxvFmhE+JnwdQMjg8tKzrQj4E0OHd?=
 =?us-ascii?Q?q7BNZ+FQbdfzO5yfPt4A6J+ZPTNnC0kPV5HD5KtJ9W/kBGbEEwbXYp2uz6yI?=
 =?us-ascii?Q?OIslUiLQ+z0m1Ywj8U7tYRAwHSy70wJsMFsXVY5VuswY93GkX5WkiC8lQ+m9?=
 =?us-ascii?Q?z6PzYzVXpnvU6gU/TG0e0L8p1H6LxDpT1vSUCad7csa1Dkiyevry6L5biBCy?=
 =?us-ascii?Q?h1mUfmFHW/06gKgoZJHwFZgAGEBXOaRaKILkJ44/e2wT5YwL+UEoVPMImqCn?=
 =?us-ascii?Q?QkEf0XVTHRHfe5IQi2YNVj796eyS4WER+UxHJsp/Q/TFJvx8qFynYhdiRmTZ?=
 =?us-ascii?Q?d94N6GYt7aB5E3xaq0G80VQgQBVH8Z1TfO58m3zPGd6dSzbIdikzuB/evjff?=
 =?us-ascii?Q?6jeuL26JCdkzv+7zBQX+ZSXJZR8zL+dxWtrHNr3ejVEfCEPoAwnHp94EumIt?=
 =?us-ascii?Q?nNQ9frA/Xdn8mgIOSz01rxkZd35Y//mFVME2s0U8UQPgo0G5CpVhcvI8vLr1?=
 =?us-ascii?Q?zDyunEq94dbahhHVfMR7EnVW8Bn0p1DGTWtll3RB0TMc9MSWfycmHxIkuZRa?=
 =?us-ascii?Q?qXpcuLYffYbzeg9Zb2wAub7k5tQJ0gZ8bT6mV1VNVj7zWiGjs2qz8s/3uT2s?=
 =?us-ascii?Q?Q3NN9fvlQVWDIhsYZGu1LudOI3vZNGEVD7c3fmzV92x7Q32g/QUguVcV+xyY?=
 =?us-ascii?Q?j7Ny3vmbzmWJYsYyXFW33GZTZPr7Nj6/r4O2EHFnBx4OIkqtn+ljhVULgILT?=
 =?us-ascii?Q?VwHN2/MR/jdSTDyeW0uCRArF855ygJqYWnpc3d4t6UBp3Yv1Yf+xK8bPfAhw?=
 =?us-ascii?Q?hJ6B21X6cY/OQBSjpiKJDITaLepzGqqNSDUSx25phJ5AZSDwSTXSzgEqPQcT?=
 =?us-ascii?Q?rr47RjjD9DhM01Os2DF4VQ/fMYAxGu6IG22YL9e6IFeScnspaOj094XTmJCZ?=
 =?us-ascii?Q?LvYO3j7JvXaPKJA3zYGoOhMHR5UsE34OczbG2JLhA+j0R998UOsdNccY/BsI?=
 =?us-ascii?Q?Koche2WgskZzva5xGeqYA3FWOfJaYzgy0+KkCh+3STeQ2FaUWrifkBnMh8Sg?=
 =?us-ascii?Q?ArB54BHDEMmHg14I65fJfAdv63j4+yiI1BMkVwKdL4uapEwdaMi8GixaduQT?=
 =?us-ascii?Q?EUS1k0nEsjN/NF4vb2aiZNIFRacna4ugy/LrUWTGj1Jj8yWVaCeIbU0iJ4wU?=
 =?us-ascii?Q?B+EHnN5cywQeAHU+B2ZNOF6ehWYmJcgLXanrQZ2yneIYO2qgJtgxAZ977tzP?=
 =?us-ascii?Q?AcMSleOZOvpZYSk+5c49f8hvKhGbXKO3f9NHRac6+6+pa0Ldcm2DFph7IvGc?=
 =?us-ascii?Q?GN3eRq+IpI7q0y9xVXDC0Dg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1e7p3eD9Hpdl1UeqRNdxPvp6PM1Q2UX1hb88IZR3+84b01j8UludrJwMHjwv?=
 =?us-ascii?Q?MbZlJ0YqlG2AAfCUjNaun7CSoyOqnqdD3o1bNJIpG5KEFilLe1MMyEsoq74q?=
 =?us-ascii?Q?lmFZSkG9LLlDMA0vt9v2GYUIzaA8BSiMfiaEJhT1N57r9Cz98bmRdqDtIbbk?=
 =?us-ascii?Q?6CJMC2F59OXw4265z3/EFdqPbDo7qr8P1XxrYMFawHJNIixXfieTvBgEC2z9?=
 =?us-ascii?Q?UnAOSzpKpmla3CH8iuSC/pQsNKF1X3y3KEZMUEhC0GCgwtjxtfJynQLpk3Vc?=
 =?us-ascii?Q?mE70gdxo8c1Uhw1CM4dqnQVcOdBC2A7ftDCBUnZF2v3mlCYRsHpj+W4OQe31?=
 =?us-ascii?Q?Z+Ue/Z/Y35IGBzyx3QDOUixDHlbKPmPQTxx7gKyf7OdfAT1/TyxIkwTjMObD?=
 =?us-ascii?Q?dUyAYHES7SRJwdy7EBg/2Ib6jlRgV5rQXVxPmQYOWp4v+/RGDXxIroud3FFD?=
 =?us-ascii?Q?FpX0DV70jusFT8mjgRVZavSyTVi5axYBV37+L1IgOd5xPJ90kgLS1/nqN4Xf?=
 =?us-ascii?Q?i/rwlkgXSGPf8cspBi1eMjmUNbF+mWuc4ssggse3TqPzUWOLKJ5COdFudCW4?=
 =?us-ascii?Q?dMpgb1VY+eH6KGL/Wqo8W7YAukAwWgI/D6euTjrwZiOhbCpaPTxvb0cvH8oW?=
 =?us-ascii?Q?3FQPCKg5fxsXXKZIjQmFw7o7YA/wKSmUo6gjexA8V4y7r1/5JqjjAM0YtzB3?=
 =?us-ascii?Q?n57HvqJH0VFqoqKs8AUjWCtC8pbsaIE/EKG/JTr87GkW1njHJlMUrgcfkc5R?=
 =?us-ascii?Q?ahyJsnSaIleYRFwYVffmYYQ7NSUgi6WoP+k/rD6XjIgfyxV6Nte0hCLQx3A5?=
 =?us-ascii?Q?tPyI0s+WCQBl7hvFHJR/s9y3L1sH8Kg5VYDJKzfwOVD4cmLFHMfxtka7vYls?=
 =?us-ascii?Q?7EeJk6OA2CQgN8XnJlmNDbc8gR7H8u/SdEra9zYEt3xqo+7lF6H7RIHFuMjI?=
 =?us-ascii?Q?Zs5xNz1GhEBiZlSVTSdVKgm+UPkaH56c3xDLmocI48w0AnDA/Jw546rrpMJu?=
 =?us-ascii?Q?n9UZlqJ+m1o4G/7IxcAjLcUDDQcYzP4a3UGR40McbKqrWGuvqcmcryZJ7553?=
 =?us-ascii?Q?xNwDi8ZPKHT0lIYtHCjSUnnPIjWSeZTZRBM/5T3mKC5smnWNa2xJqmFgsl/S?=
 =?us-ascii?Q?Pfcx6PXtbPefbETjcYzybCPC0zRjS4pylrxaO0n16Wtp4aFifmDl666IhDme?=
 =?us-ascii?Q?o5hBff6dMfTWQ0Pyp8i1F5Y29aYeIhqyeDl2TkhTSyZB2V06uywlwF+hjWgi?=
 =?us-ascii?Q?wMLcuSNvwOYC6KqFlB7PqUXaZc4HUi0RJswPSaMDV0KA4E+IkiW9YfsyP09D?=
 =?us-ascii?Q?yjj95acIKKnqHbH3Ijytk9+/bknAovo0yAUpBhPsyVXk0bl7HqI4ljnz1IGE?=
 =?us-ascii?Q?KPdortZASDjbEdmJtfNiBOPiGcSNk8ufXCdQAiZcmFzgidMRUEwhCYdPM6Ts?=
 =?us-ascii?Q?/+LA6bVZNnetJgq/06zI85cQNPMbbAQ0SzpDIJGl8KliXKBYfwt/YTsYmhzM?=
 =?us-ascii?Q?HadlQyoqX7qNNxR0HatFSQRgRj7CS59DvNlcd8WBB8Jhkn6Lh4fNolUcBMLV?=
 =?us-ascii?Q?aYTLoAm/H3wkWVBWQkacPdoQDcYmkBlQLbHyIbO73cVU8FHcpVew/v/nksRZ?=
 =?us-ascii?Q?De5C3U9vODENlmqkPoJw7aRL/5+SCU3EXkldSGp6QzbRfxkohbI/xpB4BZFQ?=
 =?us-ascii?Q?ZLg9UzWmvHklewi0YymsmiQSYSRSWfP6N0tosVo7fNTEUs8W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf9aeb8-93a3-4630-35fe-08de65b4e069
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:21:07.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/FvdO4LY3CP6fdFqRqTL+xf0C95Zyz915AgD5Jdxqx//ekfPLwrVocf+qGJell7qpOU3S7a15BktCnDVEbQ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10402
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8802-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,nxp.com:dkim,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01FE9102B7E
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 02:26:44AM +0900, Koichiro Den wrote:
> Extend pci-epf-test with an "embedded doorbell" variant that does not
> rely on the EPC doorbell/MSI mechanism.
>
> When the host sets FLAG_DB_EMBEDDED, query EPC remote resources to
> locate the embedded DMA MMIO window and a per-channel
> interrupt-emulation doorbell register offset. Map the MMIO window into a
> free BAR and return BAR+offset to the host as the doorbell target.
>
> Handle the resulting shared IRQ by deferring completion signalling to a
> work item, then update the test status and raise the completion IRQ back
> to the host.
>
> The existing MSI doorbell remains the default when FLAG_DB_EMBEDDED is
> not set.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Can you change pci_epf_alloc_doorbell() directly? Let it fall back to
edma implement.

Frank

>  drivers/pci/endpoint/functions/pci-epf-test.c | 193 +++++++++++++++++-
>  1 file changed, 185 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 6952ee418622..5871da8cbddf 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>
> +#include <linux/bitops.h>
>  #include <linux/crc32.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
> @@ -56,6 +57,7 @@
>  #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
>
>  #define FLAG_USE_DMA			BIT(0)
> +#define FLAG_DB_EMBEDDED		BIT(1)
>
>  #define TIMER_RESOLUTION		1
>
> @@ -69,6 +71,12 @@
>
>  static struct workqueue_struct *kpcitest_workqueue;
>
> +enum pci_epf_test_doorbell_variant {
> +	PCI_EPF_TEST_DB_NONE = 0,
> +	PCI_EPF_TEST_DB_MSI,
> +	PCI_EPF_TEST_DB_EMBEDDED,
> +};
> +
>  struct pci_epf_test {
>  	void			*reg[PCI_STD_NUM_BARS];
>  	struct pci_epf		*epf;
> @@ -85,7 +93,11 @@ struct pci_epf_test {
>  	bool			dma_supported;
>  	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
> +	enum pci_epf_test_doorbell_variant db_variant;
>  	struct pci_epf_bar	db_bar;
> +	int			db_irq;
> +	unsigned long		db_irq_pending;
> +	struct work_struct	db_work;
>  	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>
> @@ -696,7 +708,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	}
>  }
>
> -static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
> +static irqreturn_t pci_epf_test_doorbell_msi_handler(int irq, void *data)
>  {
>  	struct pci_epf_test *epf_test = data;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> @@ -710,19 +722,58 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>
> +static void pci_epf_test_doorbell_embedded_work(struct work_struct *work)
> +{
> +	struct pci_epf_test *epf_test =
> +		container_of(work, struct pci_epf_test, db_work);
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	u32 status = le32_to_cpu(reg->status);
> +
> +	status |= STATUS_DOORBELL_SUCCESS;
> +	reg->status = cpu_to_le32(status);
> +	pci_epf_test_raise_irq(epf_test, reg);
> +
> +	clear_bit(0, &epf_test->db_irq_pending);
> +}
> +
> +static irqreturn_t pci_epf_test_doorbell_embedded_irq_handler(int irq, void *data)
> +{
> +	struct pci_epf_test *epf_test = data;
> +
> +	if (READ_ONCE(epf_test->db_variant) != PCI_EPF_TEST_DB_EMBEDDED)
> +		return IRQ_NONE;
> +
> +	if (test_and_set_bit(0, &epf_test->db_irq_pending))
> +		return IRQ_HANDLED;
> +
> +	queue_work(kpcitest_workqueue, &epf_test->db_work);
> +	return IRQ_HANDLED;
> +}
> +
>  static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
>  {
>  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
>  	struct pci_epf *epf = epf_test->epf;
>
> -	free_irq(epf->db_msg[0].virq, epf_test);
> -	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> +	if (epf_test->db_irq) {
> +		free_irq(epf_test->db_irq, epf_test);
> +		epf_test->db_irq = 0;
> +	}
> +
> +	if (epf_test->db_variant == PCI_EPF_TEST_DB_EMBEDDED) {
> +		cancel_work_sync(&epf_test->db_work);
> +		clear_bit(0, &epf_test->db_irq_pending);
> +	} else if (epf_test->db_variant == PCI_EPF_TEST_DB_MSI) {
> +		pci_epf_free_doorbell(epf);
> +	}
>
> -	pci_epf_free_doorbell(epf);
> +	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> +	epf_test->db_variant = PCI_EPF_TEST_DB_NONE;
>  }
>
> -static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> -					 struct pci_epf_test_reg *reg)
> +static void pci_epf_test_enable_doorbell_msi(struct pci_epf_test *epf_test,
> +					     struct pci_epf_test_reg *reg)
>  {
>  	u32 status = le32_to_cpu(reg->status);
>  	struct pci_epf *epf = epf_test->epf;
> @@ -736,20 +787,23 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (ret)
>  		goto set_status_err;
>
> +	epf_test->db_variant = PCI_EPF_TEST_DB_MSI;
>  	msg = &epf->db_msg[0].msg;
>  	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
>  	if (bar < BAR_0)
>  		goto err_doorbell_cleanup;
>
>  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> -				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> -				   "pci-ep-test-doorbell", epf_test);
> +				   pci_epf_test_doorbell_msi_handler,
> +				   IRQF_ONESHOT, "pci-ep-test-doorbell",
> +				   epf_test);
>  	if (ret) {
>  		dev_err(&epf->dev,
>  			"Failed to request doorbell IRQ: %d\n",
>  			epf->db_msg[0].virq);
>  		goto err_doorbell_cleanup;
>  	}
> +	epf_test->db_irq = epf->db_msg[0].virq;
>
>  	reg->doorbell_data = cpu_to_le32(msg->data);
>  	reg->doorbell_bar = cpu_to_le32(bar);
> @@ -782,6 +836,125 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	reg->status = cpu_to_le32(status);
>  }
>
> +static void pci_epf_test_enable_doorbell_embedded(struct pci_epf_test *epf_test,
> +						  struct pci_epf_test_reg *reg)
> +{
> +	struct pci_epc_remote_resource *dma_ctrl = NULL, *chan0 = NULL;
> +	const char *irq_name = "pci-ep-test-doorbell-embedded";
> +	u32 status = le32_to_cpu(reg->status);
> +	struct pci_epf *epf = epf_test->epf;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	enum pci_barno bar;
> +	size_t align_off;
> +	unsigned int i;
> +	int cnt, ret;
> +	u32 db_off;
> +
> +	cnt = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
> +					   NULL, 0);
> +	if (cnt <= 0) {
> +		dev_err(dev, "No remote resources available for embedded doorbell\n");
> +		goto set_status_err;
> +	}
> +
> +	struct pci_epc_remote_resource *resources __free(kfree) =
> +				kcalloc(cnt, sizeof(*resources), GFP_KERNEL);
> +	if (!resources)
> +		goto set_status_err;
> +
> +	ret = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
> +					   resources, cnt);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get remote resources: %d\n", ret);
> +		goto set_status_err;
> +	}
> +	cnt = ret;
> +
> +	for (i = 0; i < cnt; i++) {
> +		if (resources[i].type == PCI_EPC_RR_DMA_CTRL_MMIO)
> +			dma_ctrl = &resources[i];
> +		else if (resources[i].type == PCI_EPC_RR_DMA_CHAN_DESC &&
> +			 !chan0)
> +			chan0 = &resources[i];
> +	}
> +
> +	if (!dma_ctrl || !chan0) {
> +		dev_err(dev, "Missing DMA ctrl MMIO or channel #0 info\n");
> +		goto set_status_err;
> +	}
> +
> +	bar = pci_epc_get_next_free_bar(epf_test->epc_features,
> +					epf_test->test_reg_bar + 1);
> +	if (bar < BAR_0) {
> +		dev_err(dev, "No free BAR for embedded doorbell\n");
> +		goto set_status_err;
> +	}
> +
> +	ret = pci_epf_align_inbound_addr(epf, bar, dma_ctrl->phys_addr,
> +					 &epf_test->db_bar.phys_addr,
> +					 &align_off);
> +	if (ret)
> +		goto set_status_err;
> +
> +	db_off = chan0->u.dma_chan_desc.db_offset;
> +	if (db_off >= dma_ctrl->size ||
> +	    align_off + db_off >= epf->bar[bar].size) {
> +		dev_err(dev, "BAR%d too small for embedded doorbell (off %#zx + %#x)\n",
> +			bar, align_off, db_off);
> +		goto set_status_err;
> +	}
> +
> +	epf_test->db_variant = PCI_EPF_TEST_DB_EMBEDDED;
> +
> +	ret = request_irq(chan0->u.dma_chan_desc.irq,
> +			  pci_epf_test_doorbell_embedded_irq_handler,
> +			  IRQF_SHARED, irq_name, epf_test);
> +	if (ret) {
> +		dev_err(dev, "Failed to request embedded doorbell IRQ: %d\n",
> +			chan0->u.dma_chan_desc.irq);
> +		goto err_cleanup;
> +	}
> +	epf_test->db_irq = chan0->u.dma_chan_desc.irq;
> +
> +	reg->doorbell_data = cpu_to_le32(0);
> +	reg->doorbell_bar = cpu_to_le32(bar);
> +	reg->doorbell_offset = cpu_to_le32(align_off + db_off);
> +
> +	epf_test->db_bar.barno = bar;
> +	epf_test->db_bar.size = epf->bar[bar].size;
> +	epf_test->db_bar.flags = epf->bar[bar].flags;
> +
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> +	reg->status = cpu_to_le32(status);
> +	return;
> +
> +err_cleanup:
> +	pci_epf_test_doorbell_cleanup(epf_test);
> +set_status_err:
> +	status |= STATUS_DOORBELL_ENABLE_FAIL;
> +	reg->status = cpu_to_le32(status);
> +}
> +
> +static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> +					 struct pci_epf_test_reg *reg)
> +{
> +	u32 flags = le32_to_cpu(reg->flags);
> +
> +	/* If already enabled, drop previous setup first. */
> +	if (epf_test->db_variant != PCI_EPF_TEST_DB_NONE)
> +		pci_epf_test_doorbell_cleanup(epf_test);
> +
> +	if (flags & FLAG_DB_EMBEDDED)
> +		pci_epf_test_enable_doorbell_embedded(epf_test, reg);
> +	else
> +		pci_epf_test_enable_doorbell_msi(epf_test, reg);
> +}
> +
>  static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
>  					  struct pci_epf_test_reg *reg)
>  {
> @@ -1309,6 +1482,9 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>
>  	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	if (epc->init_complete) {
> +		/* In case userspace never disabled doorbell explicitly. */
> +		if (epf_test->db_variant != PCI_EPF_TEST_DB_NONE)
> +			pci_epf_test_doorbell_cleanup(epf_test);
>  		pci_epf_test_clean_dma_chan(epf_test);
>  		pci_epf_test_clear_bar(epf);
>  	}
> @@ -1427,6 +1603,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>  		epf_test->bar_size[bar] = default_bar_size[bar];
>
>  	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
> +	INIT_WORK(&epf_test->db_work, pci_epf_test_doorbell_embedded_work);
>
>  	epf->event_ops = &pci_epf_test_event_ops;
>
> --
> 2.51.0
>

