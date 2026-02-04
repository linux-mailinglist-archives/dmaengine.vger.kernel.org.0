Return-Path: <dmaengine+bounces-8729-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMW3C29fg2lzmAMAu9opvQ
	(envelope-from <dmaengine+bounces-8729-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:02:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB3E7C83
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32D03300E462
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246B9421EED;
	Wed,  4 Feb 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wQoJ63e9"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167F421EE2;
	Wed,  4 Feb 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216897; cv=fail; b=FH14bYyUxalEXnzdWrWzKFn3ansHCqtYAuzoHT/lN0A4MlukWxaWmb/8dUYJuALAaGWxSLmIS4+YhyVv8q50lM3wZPbmgsC2k/w8otrfdqGaoh9bISkhQw6cP6dBs9eHnZ4AfDY7isQN2Jeubpr9fToyHf+carzY7Xk5sLc8hD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216897; c=relaxed/simple;
	bh=YDiBumQ3zRfrzLp0tcQxES4quur7jDDpXDf/D5E53uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nz51spijhI7y5k7DZMxwcrqlEHsJ1bxpBoilE+h8EmIyXVbD1GAZUJdIuDq7sSkvG+gxKhuMus+63+N43398NAeSBOyvJzdi6TDYTY/SCTdpDXUbPgV5P6QmOXpzvAbYtROBYMKnyJ9aIGEtjyLp8wl1rZ9pE58V52L3X/IOjxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wQoJ63e9; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLc6z5eCBl0Tm6V0KiySwc8WDMUhrUNBPvYXLsLJS2TGZhgK0K9+TnXetZOYlSKzzJ83/h/tRU2rs+hqt/1pHVEi2VF20JL6A4HZNXsuR33+jYtbHqxxxpAOcWVRP0WmGH6fQvTlZ/NDPDoFB1sU5zw9e2rBNVXOGVCycUk+cHAwu0HhtR+XrUH1hZ8f95Iysq7fLMDeZTxMUCzG/NJFokulb2Ur9/LVJBp1GjPIVYL+/mCmPVmXxKJh6l6YcD9+7PwpdsE4b4LK2FyrUbLk1cI1U+jaFpMNLvZUpDhGaIlrrhby0QkjmGQs7d0j09gn92uPiTs1QBug7BQ5HQsUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6hPhFRD1UfaS87K9Pg4SXwUMDc0DEoGV3eiDRfpZc4=;
 b=KW3RkPHt6H9uVn6mNO6fEQpdOXFSFwp7nuOwHtFVeu12t9N2RvBCx38UryydyKkSRjRHWOUlbHnrQnWkA/N+Ot28wM46mM0cmDAkAjC2FDX24TSee+65zzVeETIbaEmaj+qOMJpFGOVFSAUdb6vjRvurx3brUBEo9Gw4Yi3opwCmM7VLYE7mYU8IGcDK/jJ56uY7kXkj9pMUglpNdrwxKyTtMw8qJgnlnL/j6qkmO+woR8nOQMDxaE5AR4eWMzdeR4XRmDrA6kxnKPjQsjxVGadKpnXM0M8S4rYUExZY/QPTlhFT5Wa4/FOftVRH5p6SGQEBebQVOrSfh6M3gRFQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6hPhFRD1UfaS87K9Pg4SXwUMDc0DEoGV3eiDRfpZc4=;
 b=wQoJ63e9wBPeWtgNLUmcpsfS6xp/paU7oVUNNGNLIfXurW6cv3O/L75vrLlVN2GgQDXz9BpDSye1r5HHtg740ulBmiamSny1NPGVFm6Rbz+WVSC3epk3BlpXEdXVxk9itpfFrtKmED3WESwF/OOEff1XoQZCSlmbNygiIVbnAC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:55 +0000
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
Subject: [PATCH v3 11/11] selftests: pci_endpoint: Add EPC remote resource API test
Date: Wed,  4 Feb 2026 23:54:39 +0900
Message-ID: <20260204145440.950609-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0078.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: aeff3be6-6cb1-4abc-1105-08de63fd5c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JoWtfmq4mkFP5umOE8sOLxKPszhkxThg1wQcpJEWMsvbbKyiNWFBQZwEN0IW?=
 =?us-ascii?Q?rggxcu9z0otsNepS66/mu8bOuJGbZg7UISq+wEOUiEDzbY5zT6pW5HxQGy72?=
 =?us-ascii?Q?ONR7K1Gmh8v3CKK1zbtFmtZ1QUfyqOyV76sqc/G5waxSuDk+MwubHwlP3Joc?=
 =?us-ascii?Q?qMiFkxYTJl2+Rwy5/seGvZa9nhsF+aIDXx8E3fy/uzAftg7jtSHyjymBdScF?=
 =?us-ascii?Q?GiXRw/eWWm3vLSwdKPS2zK6+ze719uTLZG6TWI0w9E6Csmm2cEUvh+pysdXH?=
 =?us-ascii?Q?ov6+LFp/yf0mPpElF10k4IqmRJcjc6T26FJrSzO1a0B3YiOhcO5qyPT1g1TG?=
 =?us-ascii?Q?qDXR0ho5tCwJsOfAOF6TC5A7GUvIQ/XdWq8CeL71lYrNzM7JPU7DhYe2TRlV?=
 =?us-ascii?Q?aUlTUfXVZnJrASxLCC6K6vHsWjUPwQWrP8DFMgRfyvLQMgWG/nC8bcau8MfW?=
 =?us-ascii?Q?qZWlgADrJj9vLB23ofOjJ0EQlkkxcojJBJjOovuwCUVuuVVnctE0FiEfkQn7?=
 =?us-ascii?Q?Cw8h3yqfHvbWyuIW576Capafr+PC5Do+mLPWoX4wiJ/SZLT36bIVr3nb4tOC?=
 =?us-ascii?Q?YB7OPTKbeKJFlbussX4NUZ6gAWaM7aClArcQF+04b1HIEkGeajlYKkUxpLXG?=
 =?us-ascii?Q?ap1Lel538ORNZSESQKzNdzZtQ6QAVeRJTZsoJfQOOz1v3gJ1BX9z2h9duD2a?=
 =?us-ascii?Q?CzqfhezmpBpxT6iiBd5FvNQQcc2I2uXvGwmbVHu2qyVX1Ru4PMaFlpy6eKlS?=
 =?us-ascii?Q?bU6XFMyVzYhfySrd+iT5wZrLGbVDtdZ6WwYja4OFaXneRAZjcsyGy12Yb+v4?=
 =?us-ascii?Q?/MbA4o2eDgMY9ypU/MR+XVTTT7zaskEjrfDnGjxDrk/S1FDlxY9Vqt84f43C?=
 =?us-ascii?Q?A7TCTtYfTW9aTmf4YcCs3S8mPKCDwcPRLlbXW4Z28kpu+zT9zSQ8REE9i9C0?=
 =?us-ascii?Q?0/LrS9xC87t1wj8aEzMBY8AK48EiTuy/zi5nP9bQva6OoPegz0uNNmW2+HLC?=
 =?us-ascii?Q?nZH8GgsSfcknhYJkhtlwg2FeU5PN+82jgKHSU7NDAVmNdkofm6syHIW8G0zh?=
 =?us-ascii?Q?sY61xvcl2cg/Mx0F3t6Qe7WSPYB/HUf2WTyeA84wNIzTisRsNcxBhgEX7Axb?=
 =?us-ascii?Q?go1rhY9h9H3PrgKsTRhCeWSld2BtD+suhwM7MczYQjKSr8XhJIXagzmF9sWl?=
 =?us-ascii?Q?AJ4RBC8oDWbA+yvtdjMCbJJtNLaNSBPPJQK8r50bN0ce/okJLmUgGsu2akgj?=
 =?us-ascii?Q?+gIay/uvFX12bKT7lEcANJHnGuWc4SdTLFxCmXqNMrtROsqbzscJT1B99yhA?=
 =?us-ascii?Q?J/KIlp1DnX4UKSQxtwYZxoHFrm7ln4e613Oj1gsyLbo+sbk5P/cbLaGJFsOF?=
 =?us-ascii?Q?a0P8w32NagOEwDvJN1/sCf68EG9Q0ENvctPPtwAu3vWz40Z56aatFtoG+HLv?=
 =?us-ascii?Q?f7i6ggTErTSYKGxtdFscli0SC/eR3PqraPzKTOv1zNMiTkRh5KJs1EdNgxDG?=
 =?us-ascii?Q?E40gCf4GWxYtWIo3j60raZFJvs1F0h4RPZ/0vi5epacdSgbRRRmEl27nHuYr?=
 =?us-ascii?Q?I6ZvjvUxSdNulWgD4oE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tql7nvQsOTEILhwIY1NaR+emmLNFysSoVoMz4aj16qXZn0S7WEtDYj3PDyxY?=
 =?us-ascii?Q?kTLzojcmJ/3gAZpsd64jCb/MKzliw4gSct1WY5keoAFWIfLbj4L8yT+89gKU?=
 =?us-ascii?Q?QNE2lHX3TYSmpPBchEtek/7Jc5uPJdHdPMGq7SGgGB4fXmx2N6dEAIig8ofQ?=
 =?us-ascii?Q?Qf6IFGH/iC305qBkaS90wpoO5FI8JEO0LJsQVEAVhY+kpsHvULLL/3J+TO+k?=
 =?us-ascii?Q?UbFJ2/5hel85UzFNDnm3rNIMHMQonSBxBysCSP2ynC5suLAx6BHzKdsQkv4h?=
 =?us-ascii?Q?uU5+WsfepgE4UyemAeOZkoZzjlhX09WWYD7UqNxwyony8+E+QYDGcOz0rhSj?=
 =?us-ascii?Q?/n6ZO4PHuXb/znHuszB5Ckja5D1LImgMYJdw8S8ocKM50Ll2xljkm+eZxKPx?=
 =?us-ascii?Q?cenTz2ArugQ9zZrnsbINZ2pkxJAhGQZVeDSfiJtmUnCdMMIxAuV1yjigezSb?=
 =?us-ascii?Q?7a3l9G8eXjJNZPswb+BvliAn0c9yXCwkM60jveoXffWZ5YjNNOOKTuLz6n2K?=
 =?us-ascii?Q?PjblzD0R2XAC/SemjUO2AMql6kJgK9AkrqN4nCsiFkjK+nQAhbEp1iBu0/qZ?=
 =?us-ascii?Q?YQPSwZu316RawazP68T90ZRwJEw44gc+EnQNg7KD4CYCZj083K2NnDgLBXf3?=
 =?us-ascii?Q?wcsi7QUG+e5ZI3DpYDnTujRlpa8rCrXFABNwWGCrx4rDKMV8hMju8ta6HkgS?=
 =?us-ascii?Q?tfRhpfV8MFCozhxOwerwW6zXgTDA2cIsVNC9qM4MUHn+1+jqgSOz+JqqOyqB?=
 =?us-ascii?Q?9uJdJZDz4nOJw4fDPIH/TwXi6hvdn9vdkkYr3QaV+t/04xmyene0bpKdbFtV?=
 =?us-ascii?Q?boEL5lNh9rIin+SVCOB01bmCZ/H6+qaoyliqgQfWAHIJMpgprDrqfF4Pblt9?=
 =?us-ascii?Q?AvjFhHIhZlZVXe6DOdvLkd7kOJ5OHrqgyH8nFQgMU5drpIV0cVoRUn8YKuoG?=
 =?us-ascii?Q?fbAMKvAkUCkeYwJToCQGQdaBjCvYCsdcqloL6xhxzd1Eq4WPkuqFZELUBNgn?=
 =?us-ascii?Q?npSsGC2gIu/PP6Qvlidpb1lAQigRNSi88FjZB8z8chSFuDbivFMQ2cc7Pnp1?=
 =?us-ascii?Q?07Zo0og90NJFbji8GpMeTCeGxrlPKAosoeVUEWyV3fOf5xIXK32OEyN3duZR?=
 =?us-ascii?Q?92I9Tz62+SSylYKmMmPgnGr135qGocmycsdVDZuTFkvLis9SQvjYZuND0gzQ?=
 =?us-ascii?Q?IXIkjE1N4hGlx/PRHFCf7e06X951uXpTVlbdsDG/ndG4zhQdUyku9nE7ksK9?=
 =?us-ascii?Q?wy0Qj2meWCuTOUjzpBby/IXYsQSYAmhKU0GMB2GF0dlHs8xuQGgI+A0iHmwE?=
 =?us-ascii?Q?4BNefV3X8I4hgY4xWzzo5K3VjFHpxSpXholjHZ4iq3v5SEQRWIGMpUcqdgzr?=
 =?us-ascii?Q?AkOUNliPgBaWVVMg5jTbKQXfvepYHRC4lmhZ4Wtr+DEQy0ByJJ0biMLavO3z?=
 =?us-ascii?Q?yCwrAp9mCKcTOpQ1wMkRXV8EHJzGRJz5X1xIIUht91qt+Km3dKXN3Er84U13?=
 =?us-ascii?Q?gF1AePU5P5Frpl1RAMrdEI6fgqx+GaoLALHoC10DJXQNaLEEnKWL9mrujSDg?=
 =?us-ascii?Q?rrcpe8Gz+qODYdYF6NevbkTGxWRjlWR+FOoKNqOoBRiOY0GiJI7QfL5yhtKH?=
 =?us-ascii?Q?F2w8/DBOxzOdYUejekX1VpzDbe63bCxjv4/PcLnUprE72zgUzJGn/QqvTJnz?=
 =?us-ascii?Q?ZdZZ7fWtjDtMvMmgnWH48Szo7lZgHycNq2kjQ+gPmYA+Tt4SeuooxkebgdJd?=
 =?us-ascii?Q?CgfLZQu9hPMyCbMGxeFnrIdUW+XcADOiwwYsDkZi0Z5dNlkflTOt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aeff3be6-6cb1-4abc-1105-08de63fd5c26
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:55.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1KGdN1aDgCk1Sc3uWFkrOLC6nCG9q4pFQvNORj7ohKgYZRFW3FtRUnV+5G3RypGTloZr51diBkCv6nliBQNaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8729-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 3EEB3E7C83
X-Rspamd-Action: no action

Add a new pci_endpoint kselftest that runs the EPC remote resource API
smoke test through PCITEST_EPC_API.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci_endpoint/pci_endpoint_test.c          | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index eecb776c33af..0904d262c084 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -278,4 +278,32 @@ TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
 	pci_ep_ioctl(PCITEST_DOORBELL, 0);
 	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
 }
+
+FIXTURE(pci_ep_api)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(pci_ep_api)
+{
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
+}
+
+FIXTURE_TEARDOWN(pci_ep_api)
+{
+	close(self->fd);
+}
+
+TEST_F(pci_ep_api, EPC_API_TEST)
+{
+	int ret;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
+
+	pci_ep_ioctl(PCITEST_EPC_API, 0);
+	EXPECT_FALSE(ret) TH_LOG("EPC API test failed");
+}
 TEST_HARNESS_MAIN
-- 
2.51.0


