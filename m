Return-Path: <dmaengine+bounces-11643-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hM+kEmBpNWqNvgYAu9opvQ
	(envelope-from <dmaengine+bounces-11643-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 18:08:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C46A6F0F
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 18:07:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=QFqNh7Nu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11643-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11643-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D7CA306D8A7
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739E25A2A4;
	Fri, 19 Jun 2026 16:02:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7103B47FA;
	Fri, 19 Jun 2026 16:02:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884948; cv=fail; b=Rr/k+ginl3VZh0XANWBEx8r+l+c75MTK6c5NF4NJBmrb7jFDsdNaPh30nv/4y5EWMlhEiolL63yOm9l39IRfp7DhLGgwmxT2bVoDBGu59SDJr6dUki0Z5tYNDOHRkRaO60xznu31Mo21gFK0p4nh8wfl0UGnRc49EI8oujGIR2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884948; c=relaxed/simple;
	bh=EcvUf7OdLsXPAGu/GF5aPTt7ytQkImAnI/H6rd85EJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jSpvBem1WqpBN0YhjvijnaWEg8Sil1fNZqFgDTSLJj6cT7zhbuCxqUTJufy3ipbp2vn/Zd3s3XWeK21sOFbCQ5kU+4jyGZNIp7VjURtU6MAgFB8bRfNr9Fg5YqPYdb/nADqyP00+80VvYXR62x0OJn5+Vf55gJu3GGCWMLyrgv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QFqNh7Nu; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrS1DNZx3TWjAZz8cWsdK6MBzIas2vz/6v5DakemkCj3D7yuFsg406YMcxFf0zE5N6Z6W7PgwGF8kaWRo9GdvigMETZxxzWIV8J4qrHFunLEOk8cepk9t7M8T43bIKayF9l7QLZZakXRk6hktyzEVw0k30bfEePtfZfrAKokp4hptmtlyQodWtYQB1u6vYYfjBkPPe3x2hs3hryQa8hBjnNxMgZzsc3c8SRtZoVDqPuYTlEiDrGwhowS39x7GeKx/Huwg6yiLRZUcXJT29k9yESUKcuqOVo4A1TQHTjR2fDbRM6L84Q8qViDEiM1P4qQHurLVvLBtj6SR0QmUe8Gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPwHTx/13kS/vXqI49rzgNcOFLeBv41/aD2yzWxYUgo=;
 b=YJaVU1ZsyKWXzw9bIsI90KlmvKy6fw6D1DaL0xlFsvgGWD6fqK42MtcWBGX9xlh6GqgA8XgW8RnYKTjGsAV+qPG5pTcQl724/8lc8GAx04u9FZ/la5f0LnzbPLF2uKd/HNjFIb/q/XMEJ9UvwjFmIzdML5ZlyQHi5bepeJ2dxo4ePuIaQBPWVRVe+NhXYekFw2HhuDkzvYz1ndmI9EstuxDocqjbA6TO5upu3fnjl21XkbeQ7kL/jiPtCz2IKI6I9m03IwvEBxYxHIp7m32U+ywYIiFWTbJFKElfVYuLXXDfd4kai2xXG6VZ1n4k/iWnyz3CXlqVvMVer1yzsEsgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPwHTx/13kS/vXqI49rzgNcOFLeBv41/aD2yzWxYUgo=;
 b=QFqNh7NuPJPzby7PTtMN399Ll1IG4KrTvQSigHXxKIiKM6QpWCg6wiALhkvgrjufKTAvt6zQOkRjOebtDMk/wp/ynRLqf1dJCHiwkjzqcoQ6YtDHGfBLzYNgqMcOC7k8RfBDGefGvg2nBJ+qQ02+C1fu7mtbZf1OZ2uVA+2DlFENTYDFJWMOKzNyGeWxHapavw2LC8zNUNahsBSqG4W7GEwVBiVxmjdZyv/d72pjnEaRbKLjMtqBhYFtFP8dG4EjrrwBX15CtF4pl3mhY0anmHumYOpbDzsKjW/C183VBqIaez8iZNDV4SWmGa8IigNzvwOd0fYsSjojl+ty12XD3w==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9223.eurprd04.prod.outlook.com (2603:10a6:102:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 16:02:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 16:02:19 +0000
Date: Fri, 19 Jun 2026 11:02:10 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dmaengine: sun6i-dma: Add set_addr function pointer
 for variable address widths
Message-ID: <ajVoArSGiUybjk3a@SMW015318>
References: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
 <20260619-sun60i-a733-dma-v1-2-da4b649fc72a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-sun60i-a733-dma-v1-2-da4b649fc72a@gmail.com>
X-ClientProxiedBy: SA9PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:806:21::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dd88d7-5df0-43e9-a359-08dece1c2425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|19092799006|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	QojBj8arlAhpJtHnMSUFAHVMa3oovPcasYznks74re0vxnREYmzZU/ho9YtHQG2cgdK6wXkhjpQbanhtGkL+dICgHRTJhwFzPm4U6oLr4V/tMTTGwEt2Qvb9zsD820vRQUCf0yyuE24aHVnbRH2KcCQDsUVWlxuPWxrewC7qLOFXxuBIOXRvT8+l06kT6g5WchZXGmuACY0fRo8cbg3aNd3j+rA5ZOgifgdPOR7nyo8gzoeljsKGzJS7wKEaBXiGUGnizX83uPD3nFYvjsJ9TOh2EaQbQvlcv8fgyfDMO3sH2RYZ1pG79oXHJHc/GOo/oWMLUcgtr9eRHEUDgaa5XAlr9ZB412n7uVkS75DMAjC+qJKsjvI9dNz5k6UgkQZ6KV4CD/d8aTnwCdND2NKmHxk6/ddurQQAVY8YLhHV4txzTHZncMwfgMdHiUZsnKk+9VLR8mih1wvvVyB1vFHjXah/zhI6MSgJz2TSMvcEHz3v/5LDdzOdZsoNjk0v3LzAUKwpjvMVx/sJBLZe81TbBtGbCbXGNz3XhjhnjtSw70iZxtJnt0JbpMrFgZswNIIbIlsWZoTu0z2HdcbXOsUytyH5ai8+B/l6P9dBuI2klalnQW2iDhUgrAVsqe4p0ufYBew7Yzf++AMhanQjU/H7yK9ZYLTxlfTDs+Uh9k4gAd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(19092799006)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RnLaHwktOzSClU5fY6ywiAr6j8EgQG0UPmkivvtgc0UomUTLGo9USW9WBHE?=
 =?us-ascii?Q?tOpt7WRUlfeGisoOvYKy3j/eAUcA9obkDhHxweL+pKM8HiOgkb0jY/QMmjYo?=
 =?us-ascii?Q?kkv04AUZVsEa0LRo72Qbi9+uUDA6i9zPn4BBJMDnw8rtfckhFpZcktzO6Mza?=
 =?us-ascii?Q?gXSTfHUnbAJq3R6hkIKuX9aAkjsc0xbmCFENIodESat2kWqNa1hp2AIxjaJc?=
 =?us-ascii?Q?3A/Ls6fcj34CzWK42e+9xplcojxeta4pFDkLO8S6jyCZOrFkyN5/OBCWqIYd?=
 =?us-ascii?Q?eexidsFpcG7ZsZAcFOkhwgavptsVJH5NKUfFaXAnxbhY4ToDRpRi8KjRVoP2?=
 =?us-ascii?Q?KAaVhGn03I2ckEUEru/Ez5YefXJEIZ1HMsfp2V1q7uwmGcmQm4BBpsjdF6Xu?=
 =?us-ascii?Q?65DyxONtqDZ+cTXonKLcJ/KHbOFrQGKUbL14vUWKoID9MUxoXWqAlhbIreAw?=
 =?us-ascii?Q?07gI6GXACLT1rTcMQgABADBWb/ogCqYRBtVO+zWlo5k8ANr/aqJt/RweJRo3?=
 =?us-ascii?Q?P1/ABM6b9BK/xCLjSzWc7Si/3ZfKI1xRIGWhSvjlFxW0hulRzhkvfOzaDLRj?=
 =?us-ascii?Q?WcDi777dw4uHcTjUJ92TqTZFpEAjgLCIZjBU9ELyHZJ4ITLro9XmvTZBZYO/?=
 =?us-ascii?Q?Jpgh0bq8PiRA/nUo6yPUFQSkQVI6+ZfFbGNqDV1viw5ohpI6EoHPuBnV5/O2?=
 =?us-ascii?Q?lXRlWqtHA3FQKaL/y2us9qmqjzBrIfvhdjygLv+j49wx0K6Zq83mkVFEpOwc?=
 =?us-ascii?Q?uk2VKoWOTt7PF/Fh6E2yUSQxdmWRUUo0YvfZSqyz8YISTANru+GRWG5XFraG?=
 =?us-ascii?Q?8qKWMvOOUeGnpvQx9ZtBv1GR1YU8YpBEd5SaJ6aMFuJTRaArJcspIZy43ZyP?=
 =?us-ascii?Q?rvMrjnqWiAhuYCRWI2MSGcvXsJ/iYDnmQjoOQxEIqjgANw04+QRN5aAhMF1a?=
 =?us-ascii?Q?aUQDQP9hK2sYVky4bAyI374sgp9+ubsUCrH8fVtR9FRvuFI+iavmEHoIuo9a?=
 =?us-ascii?Q?acgSiuFsQ5MLtLUhXmE8qlWUusPVTqDupnyXi+J0ed4eAlecv/6+R/MZFJYH?=
 =?us-ascii?Q?C4qHRmAkHTUEW77lcu1ni8nPkJFYW1p1bHuHarnNAP6s3MHDML1BdnVJKetD?=
 =?us-ascii?Q?npUcitgRTF2zGcSAuZT/XSkaA8OHnT9+9Si0CjUNrrti3Gtu2FOZWTTg80Di?=
 =?us-ascii?Q?zfDt5ERGSqhlOMXkc+YScqKuiG+nCN5c+2C4rjtKwNEy4Y9UQ7upvwi9H1Zg?=
 =?us-ascii?Q?teCfGodo9DM9q0mA+fPlCi6mJzSAMo9mSpK7xnrzoejOvIaHKErSSUPkjckw?=
 =?us-ascii?Q?AI1vMrz2s2esGf0/nJDbkPW+OtgBSPc5qhrPD5U0y9zgTXj82Yw1oPZIX4No?=
 =?us-ascii?Q?Ub547coYejrSuDECcnKKrEu6mNXjlRZDoHHkgrGWrS8Tr/l+SuOmVZFw5sEP?=
 =?us-ascii?Q?5Z8SS+jVXJ0dKd61oppKgPs/xM6WpWJzAwZzMGr+4fDBcFFMoeM96oAJWVPB?=
 =?us-ascii?Q?GuRdc1Al+kSMuGsfi9JUyqVL3dljHWYeefveYQQJ6ZwBzhknZ44N+Mog/Njg?=
 =?us-ascii?Q?OLx8riytXmcasuKMhrN231z7R6U83kr9EVJVQbhvxvcsmDx0xs/V+/Bi6gEZ?=
 =?us-ascii?Q?tM3SO++E8trk9nL+3B8/aTjNr7Ai6mSdTO+gKrtNBHbZg4bcZ/0o9Lhq1Ca+?=
 =?us-ascii?Q?4q+qS2lI9xXZo48Gzy2h/LsOYg6FYP7tB1chQjmLqGcG87hnRwOR1deKPWuX?=
 =?us-ascii?Q?V4VhrzYpzGlPAjCc+lFx0zjy8tQaXI9CmViJSDquZgq9C/XZGs5J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dd88d7-5df0-43e9-a359-08dece1c2425
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 16:02:19.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkjQoJ53iKxcv75c1e7i67zGzZWuOFPDqUTzOq5Kh2ulXm4Yokas4NFrOZm9DpaULR9PcMNSw3RZxBZ6a3eeDcxrn93haHJQVqvVTOofhR6NVMKIlQxuQyUvhmMfVBxk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9223
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11643-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,SMW015318:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B38C46A6F0F

On Fri, Jun 19, 2026 at 04:53:31AM +0000, Yuanshen Cao wrote:
>
> The A733 DMA controller supports higher address (up to 32G) compared to
> previous generations. The existing `sun6i_dma_set_addr` function uses a
> hardcoded logic for setting the high-address bits in the LLI parameters.
>
> By moving `set_addr` into the `sun6i_dma_config` structure, we can
> provide specialized implementations for different hardware. This allows
> the A733 to use a version of `set_addr` that correctly handles its
> specific `SRC_HIGH_ADDR_32G` and `DST_HIGH_ADDR_32G` in the `set_addr`
> register later in the series.
>
> Changes:
> - Added `set_addr` function pointer to `struct sun6i_dma_config`.
> - Refactored `sun6i_dma_set_addr` and introduced
>   `sun6i_dma_set_addr_a100` (keeping the logic for high address
>   support).
> - Updated all existing configuration structs to include the new
>   `set_addr` pointer.
> - Removed `has_high_addr` since the logic is replaced by
>   `sun6i_dma_set_addr_a100`.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index d92e702320d9..059455425e19 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -112,6 +112,7 @@
>
>  /* forward declaration */
>  struct sun6i_dma_dev;
> +struct sun6i_dma_lli;
>
>  /*
>   * Hardware channels / ports representation
> @@ -138,6 +139,8 @@ struct sun6i_dma_config {
>         void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
>         void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
>         void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
> +       void (*set_addr)(struct sun6i_dma_dev *sdev, struct sun6i_dma_lli *v_lli,
> +               dma_addr_t src, dma_addr_t dst);
>         void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
>         u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num);
>         void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num, u32 irq_val);
> @@ -147,7 +150,6 @@ struct sun6i_dma_config {
>         u32 dst_burst_lengths;
>         u32 src_addr_widths;
>         u32 dst_addr_widths;
> -       bool has_high_addr;
>         bool has_mbus_clk;
>  };
>
> @@ -675,13 +677,20 @@ static int set_config(struct sun6i_dma_dev *sdev,
>  static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
>                                       struct sun6i_dma_lli *v_lli,
>                                       dma_addr_t src, dma_addr_t dst)
> +{
> +       v_lli->src = lower_32_bits(src);
> +       v_lli->dst = lower_32_bits(dst);
> +}
> +
> +static inline void sun6i_dma_set_addr_a100(struct sun6i_dma_dev *sdev,
> +                                     struct sun6i_dma_lli *v_lli,
> +                                     dma_addr_t src, dma_addr_t dst)
>  {
>         v_lli->src = lower_32_bits(src);
>         v_lli->dst = lower_32_bits(dst);
>
> -       if (sdev->cfg->has_high_addr)
> -               v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
> -                              DST_HIGH_ADDR(upper_32_bits(dst));
> +       v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
> +                               DST_HIGH_ADDR(upper_32_bits(dst));
>  }
>
>  static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
> @@ -714,7 +723,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
>
>         v_lli->len = len;
>         v_lli->para = NORMAL_WAIT;
> -       sun6i_dma_set_addr(sdev, v_lli, src, dest);
> +       sdev->cfg->set_addr(sdev, v_lli, src, dest);

can you move sdev->cfg->set_addr into helper function  sun6i_dma_set_addr())
so need't change other place.

Old sun6i_dma_set_addr() rename sun6i_dma_set_addr_<name>()

sun6i_dma_set_addr()
{
	sdev->cfg->set_addr(sdev, v_lli, src, dest)
}

Frank

