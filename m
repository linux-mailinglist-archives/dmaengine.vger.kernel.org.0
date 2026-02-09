Return-Path: <dmaengine+bounces-8849-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEAyDWoDimluFQAAu9opvQ
	(envelope-from <dmaengine+bounces-8849-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 16:55:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9437112367
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 998633017046
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4CE37FF67;
	Mon,  9 Feb 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7wGSoXY"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1172BEC55;
	Mon,  9 Feb 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652419; cv=fail; b=K5HDRBTtjBZOoiCxdnpGRdskjt0hCOaLTzIq6iCwyzk1cUVtY8NSt9ERcF1DDGvWLzDzsSb3H2AHW//afgjm+tchvGkxY7JrcSDyfWsUeGEal5o5tjn8inJnRbbjhD9TfusXaGMjUjjE2/e9L1K95bK3cXfTQNhA4kZ6d3bceFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652419; c=relaxed/simple;
	bh=qQLEvDQu8WWLDgwIB+taYXudoydw8PKpLIUEQWTamdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qezHOBiaCq5cV5CRe6ahPAIaEOfXZRr2REWH3FnsQ/W6/uAfCrmUKVhxFSJmUOl/fIeIri5yQPAMEve3RDqjT8aiUGo81Y9KcMIBQKd8n0OmQ/5340FK5KbgJvKNVy03M/uV/3Zd7DlfWU/07f3wVj+/pPv2rE00aqamB+kCT+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I7wGSoXY; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXz8bFm9KrSjvVynQjQOUHgDuQoZQl0gE9m6I1aiqzEpsYvtjEYPyOKatSu3w9jVmBFDhUeAazNh0XQeq6iv/RF9tSwxZUCt88TS4jbJdDH5x/wsfIUbAbBHbZL9/39/6OojetVd6zHeDh/HUenj675i6cRfOyGDp+BZKonsu/SdVi36kVP+7VFCII7ECGdV0WKjCAexROV1wBQ6rB1d8ZV7+nFCnlorvFjD1o2n+eIUNHZJcP8vwturpIPOba0CaBPY2m1JBhKZVpm05zzTKaSGbFZBVcjH8QCL00xIptcLxbp8OSNrzu2uEY6EizErsQ0iD3p2rDyDX+EVHz0hug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MKbDp59tDjIfaD43TzigOJe/dybCbGUgX3GQiN8c4E=;
 b=gxLzDE6l2FO0HZrNr2wR6LsSj3NRSprNx6lBUd0GjOP59VmTLwYShBWlANMngsiC1CM5Ys181IsKO1Ksu6KVjIUlatSuMBFgHv95zr9UKrisGdLdpL8IcAB15Nvyqmdj443G/749nE5aDQJ45PxMjqrADFw3xxP/8+Oz78ph2tRGw7rOAw1yBr7HDRjnbkrfZvEahi+LrXAWOxQ09+KjPN1Z55NhgFLqeI2CX3FlV9yzN5nI6unkJ+3woKTHgpmpj+SbNoGgkkHjhlm/cL6BGEwsQSmIn5CKEhCtWR4fQHf2i61OduPl6ephq3UOj9/040siMMmbuL37X9bETNi0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MKbDp59tDjIfaD43TzigOJe/dybCbGUgX3GQiN8c4E=;
 b=I7wGSoXY0AIgpF/YzAXw6AGnLBglrb3AUNvJ3pU0Oa/0hVY+2yvfEpbvQ27TjrcKD7sSANoLvjEaGsk9YHKbP0g5OFfMmRpGSMP4CpvB5fbjDuQRkh7tFly+GmiK693NHFAYSjOHEiVeoHngusHWXBNDxUrb5aMOu6x0glaFMs8pXRnUI7YqsDc3APe/B8+A06ycmj52RNRkXY4KxNq+I5DLRoq6JTdc4Ccd3yRtbduIC3TaLWLGhTTyf69hJdYPHIt33L7ZK8wma5ezJtl86wijH/GGB03ECLLEM51ZmI5oqkIOw8buvUI5gAcfQrcIahOleDJkPA315yTByExyZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 15:53:32 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 15:53:32 +0000
Date: Mon, 9 Feb 2026 10:53:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/8] PCI: endpoint: pci-ep-msi: Fix error unwind and
 prevent double alloc
Message-ID: <aYoC8_YxGX5fZmr7@lizhi-Precision-Tower-5810>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209125316.2132589-8-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e49c83-2fa1-4730-af18-08de67f36076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OIh+8EiqR8oorlFHVJd5Con696TpnBgslXIYRHuGa7rEAjsdPWewf7AYb+yH?=
 =?us-ascii?Q?QdYtaBx2ashHEUNo3adGiuV79s8M46T0BH9AwwLWX97NENzBiJksyi+n651l?=
 =?us-ascii?Q?7u+9PCwVHjX+F4HnroN9TZISvWFwIyqq2uQnlKL5nYBcO4qBYi2qdyY3xUm7?=
 =?us-ascii?Q?JiG86eiPYbZgVwEUkrq3SzHaC8vnbmhSkuAaAskhzCzEju8Pxqx00yG7BhXP?=
 =?us-ascii?Q?mE3tOyTULUp+mFD+qD6ThPKlJP5p6Ddd3vQH2gnNQ5o8+14Xd847McH239Lb?=
 =?us-ascii?Q?jL/plEBTEQ8a3ayHkfWwV2X92+xtJpAuomB/yllS7yAn2zDsFPTF279Xn4gc?=
 =?us-ascii?Q?C3YbsBuBdoDi0ZTgj2Q3DkVVKtavOYDmvqkokWDWtMVNW2AmYbHlfH2Era+N?=
 =?us-ascii?Q?a71E+A0lenu9GcMyuleZOy8ldj3QDRmnJbzbB8SwdR8pDyjLTO39VHveKmi0?=
 =?us-ascii?Q?nM6YnCcmg+IfrMTTdlXcceydjyMUXPRU4TbWkl+EmqZRaKxuZNrRysgmE+uW?=
 =?us-ascii?Q?85i4/o7MysGNT3JNdDX1dRw5sOnNm8JTMH5SSiVuavl/aH4HJwBhqr+svfev?=
 =?us-ascii?Q?8LrpVAJ4UmZYdJVWsqa4wpkbr6ZYnTKKq2fnCOhIJ/Qx4ENUaCFIdNHldn2t?=
 =?us-ascii?Q?/1gAQ6fDkFs+X9rXx8AHZ/+YFq0vY9M1NkfpgBAEih7KZnED4x424a2w8WJH?=
 =?us-ascii?Q?5xe/kK2W8emzKMGzXhVa+lUsUqWOIae3Z66yuJ551bP2RgjUL2pwHHydpGSl?=
 =?us-ascii?Q?YoEyRsGifzUtQr371kfdPMtDlCfMs1NArNGOfT76FKGN2DhQCkKAOLXV5IqF?=
 =?us-ascii?Q?IgM1YersFjJXl79xFFDwry0oios9XZICbruf6HNtK6NYEs4qsLyFT8W9O1Pt?=
 =?us-ascii?Q?XmjtvmTwbmLrUgSDAZ4sDPsQSaQ251TK8nMeLzWWRT0mqvrCtTb5/box5Vpx?=
 =?us-ascii?Q?cU0el7LNNu2Wq3+6s/DCTxbXgea0PVKnSie63ZOvrfB7IB15Fe9PlwMKw4uX?=
 =?us-ascii?Q?so9/HDoU3ZOc02DH8hj8iboP7i07WL9ga6JHE7qNkPNreISCDIsk1NRv8s3a?=
 =?us-ascii?Q?KW2uSTaPgpfPW6rvc7/jd//GcMvflttKjor7oY3Ugs9CAeoikDQLBiazHvqE?=
 =?us-ascii?Q?V6jB17716pj/MwQ3olwFtBqm/ArsnpEMx0opev/pDJfcR05TFpv1PvsDnU9F?=
 =?us-ascii?Q?thMJudLtHEG3Jss8bkm3LVoPeZhyvaEpWcHZwFNLbEMY+tQSQbII6Baf5iS4?=
 =?us-ascii?Q?l4Mw58P5Wcz0YOjE8muBAlLdL2NzJdIHpbRwPwG7614u65JA1MX3Jx5d6vur?=
 =?us-ascii?Q?fMEDLm8Q5R0MhUgYLWp+1MQT+K3CcQMuVuJDVUzpedW02dICQgA7Smr0m9RC?=
 =?us-ascii?Q?xorIo+GLz1PWC4UfFIeGlZRqujH5PpOIKb9lzI+ck+XTqc7ts9KdY5YwvBrw?=
 =?us-ascii?Q?fPRThx1wswprNZP59MkVMoYtnL/kGwlYPayjdozuHN9QJm5Q+Rx30MhjcxNH?=
 =?us-ascii?Q?KRO5VhYFTjGiRI1c4wLzcfSqGb/92/c3KBmeS60TLInLguK1iY2MRIppTKNl?=
 =?us-ascii?Q?QZx+nu8ykgZJoHdm2zagoLzed5iGcSPDevjr7QpUJPmTf6o0gaF72/kjeTiD?=
 =?us-ascii?Q?RKtdWoIQ6iXxCLQFmnChZTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z/XtwbM7mLF44SNuhltlApY12+lUP9OWMFBuGDmnvNhqx/zy3iJ1wHX2Nvxf?=
 =?us-ascii?Q?PwKEaamT7Duqzhhq7bpX+H1eNaBgB0WRTxwOXjC4DZJ8p7NxLNXSBVr5Dd9u?=
 =?us-ascii?Q?9H8P/IgDRxwh5MVQLMuTceIyVNe1T4diuBwQqnND6kMIFj0KAslaO9BNQFLx?=
 =?us-ascii?Q?6H6P5WCjH4noP+lss1RIrekINMF4LVPtJH/7zNDd8NmwX829aulL1J5rjP4K?=
 =?us-ascii?Q?4r3Tf7JHrCLltyxGqJpSUbGOYo2/QbmVApcEsH3NW3y36JAX/fFFkyEhjKZz?=
 =?us-ascii?Q?bLJ6JuZrtXzorvyFhGMgFemEEt7oE99+BJ8cmfI6Mgwm3CKLKfbJ9sn4O7dZ?=
 =?us-ascii?Q?H7PUveIvG0MOcBCkYuXXDEcvCSYFsCupiSSF/cVoseGrmjLEEBlZ6he/q3my?=
 =?us-ascii?Q?7ELHDOw7IyvW4JitjsHYnhtRijtnUblLnreO/1x5qDdd2sXcGiC/3ZvtX+9d?=
 =?us-ascii?Q?92dspWR7nNTMyCtZlWDR0wJUYHPDEI3kNnIe4oeZGxD9pQGRwmu5GF8wDQiK?=
 =?us-ascii?Q?u8ytd7FFrY6bbRESSDuXDMuvMfWgCp9UwR/6ACum8I4Hi10RCKLc1yOfzDJe?=
 =?us-ascii?Q?wgzDMQFyY52UIt2o3Ftw+4wlPQTf+MBPmN8q8l62XJvkaRpYgK8Y87gGS/+v?=
 =?us-ascii?Q?V7O6oviDzPyLNoR06pmFOKUXHQ39+cb3QrR+04MOs9fnm9KpGoQNQORvMKGW?=
 =?us-ascii?Q?eokh7TMHtzrQaSY+oirNWD59Et5CYUei16KGxcLlo/nBGaVggd87u4sXN6mj?=
 =?us-ascii?Q?nCzzw3o2KeNDLR0GgwFGBq/aocoY4qRyonktaKpglGZK5+y/lP1NMi3AVJxX?=
 =?us-ascii?Q?ABbfNtmxOTmYF+6MCkri6bCXKfV5u47ZdvpL7oR9TJw4b8SHWvm1HG1spKBC?=
 =?us-ascii?Q?Igcer/86yHt5MYLVj5OZZR4dLBU+BAXnbY8ux7kKEh+U7kkB9Y9r7/B4822j?=
 =?us-ascii?Q?q6MrWUlSuH/m5X/e+j5rsi9nMg8/01ZIHiGQoOojiTdkMfMr5oBefzvzi6+w?=
 =?us-ascii?Q?Jt+qWlekRLHDJzPKjDbhW4+bESs0/PS1OI4w3crwEokYVSKQbPjrkOwImE5r?=
 =?us-ascii?Q?+jAA/NVG42cGCmuoXDSAzoUeZXNI8V/KRidL/dC3+E6aTPC6C2aaTa30pL04?=
 =?us-ascii?Q?/B+q49o8SFLSEZoES5DGOYRqCMzBwnOIgPtNzjkBWR1Kfqm45FOO66hHFc0I?=
 =?us-ascii?Q?MqT5cxooP0exubjpvKrBNJH4U5xYBfYznX5U6XL3JHOuJOlzmNEO6Rpml5DR?=
 =?us-ascii?Q?CZ9s8UeEcDBFyR4XcvUieR7mPNQWzWp7mM5osT3n1ZPpEpSxso3e/h+efG7y?=
 =?us-ascii?Q?9cCPCNQTFDeGnWyBqp+9KWto+kguaSSA8/u8i8bojh30opXPd/la9hEkhrXZ?=
 =?us-ascii?Q?wlzWZreCvcZihvw/crgi5+fYm9K7akVyXLWETQKAjceOD9BDwn8Kq+UikbQc?=
 =?us-ascii?Q?qDDD3TT4RMgSLP9EZMPnyZO6qSr4ED9MtZWagn+MNI09zO2CyglOMYOBpdoI?=
 =?us-ascii?Q?taULpfFF/GneaNTTnviIA6Ar/QqWCoDtmGdbhyAj85/J/YfAq/fiOrrb0NFZ?=
 =?us-ascii?Q?0zNPYzD4y0stPTi36ewrTj1YbgEQ5q1A0fVwLOCKctSsWMwilUeI7l8hUFas?=
 =?us-ascii?Q?V/s0LFylVE5VJVP22I0T8DlqQZsUYAUnRgQ8ku7Uk3ONarzhql/sJKiPAt3D?=
 =?us-ascii?Q?CQJSusPt/liF8v54tJbSb54ducdm/lDFMd8OJq4RmNzRp5ae97LNudpr9H0u?=
 =?us-ascii?Q?WBw/Xf7UnQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e49c83-2fa1-4730-af18-08de67f36076
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:53:32.7815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBVfv1vFpDWsG2H+uZqzjRLUG/luV+Rzg7hKRkuDr0+4BmXi0+AM2jjfASlA1BwHsBTXPr5iA7nVx0yzgxhHAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8849-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: E9437112367
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:15PM +0900, Koichiro Den wrote:
> pci_epf_alloc_doorbell() stores the allocated doorbell message array in
> epf->db_msg/epf->num_db before requesting MSI vectors. If MSI allocation
> fails, the array is freed but the EPF state may still point to freed
> memory.
>
> Clear epf->db_msg and epf->num_db on the MSI allocation failure path so
> that later cleanup cannot double-free the array and callers can retry
> allocation.
>
> Also return -EBUSY when doorbells have already been allocated to prevent
> leaking or overwriting an existing allocation.
>
> Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Thanks, fix patch should be first.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank

>  drivers/pci/endpoint/pci-ep-msi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index 1b58357b905f..ad8a81d6ad77 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -50,6 +50,9 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  		return -EINVAL;
>  	}
>
> +	if (epf->db_msg)
> +		return -EBUSY;
> +
>  	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
>  					      DOMAIN_BUS_PLATFORM_MSI);
>  	if (!domain) {
> @@ -79,6 +82,8 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	if (ret) {
>  		dev_err(dev, "Failed to allocate MSI\n");
>  		kfree(msg);
> +		epf->db_msg = NULL;
> +		epf->num_db = 0;
>  		return ret;
>  	}
>
> --
> 2.51.0
>

