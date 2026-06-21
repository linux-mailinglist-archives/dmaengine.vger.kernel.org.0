Return-Path: <dmaengine+bounces-11700-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fXADMKJjOGpibwcAu9opvQ
	(envelope-from <dmaengine+bounces-11700-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:20:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9606ABBB5
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:20:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=x2dlQLV0;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11700-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11700-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9173021704
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 22:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC461377007;
	Sun, 21 Jun 2026 22:20:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89B2D2382;
	Sun, 21 Jun 2026 22:20:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080415; cv=fail; b=r2WrjvMFU72dEp/OXNJcfCP2oEByaFXLxo3H21ZVDAfrDTQaxVBHOOJNKGgFra5j/1hrJwuhuaVbqhCJEBPwXAaLph697azUkHXEBPfiPYW9xekHVfPo7d2Hu+kmpRuasdJA7IiqD7+yhlopxlZvQMAmo1BlpMYfeLifCie0SFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080415; c=relaxed/simple;
	bh=UlxBxPHpq5X1SrkWLrSuurm6yC4Uz9YdR7sqnhrC8J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PuZ8n8veDKgWZP/SeWp5qV2SKlCQgc+YPrB1jOtG/GbCCx4waU6iZ7+OhbOgcBRJHHzbXSjblcpo2dVSkw63mKwZRM/409EI5AMwWgzi9r998q0Nj3suFh+WcEf0p3gxRdse3ngke9UqPcLcddFL15xDgUDJyYP1u5FJvClGTXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=x2dlQLV0; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUyw9kB8fdb0HToe4Sfc0m+w1qO0VCpQrDfKHpHPeOJz3XBY49ReuOZcKceLYDlPnHz8jigl88J/CefvmUP/AE4S0DfrWhVQpnygb0aTdKpAWTMN081CZWlD8vI+cLE4NDsbOOiQo3ce47D6uG2mHxnNgyKz/7HcPi9EdudlEvxkVC1e+4F4cTQpjBHiO6zmTbpPh0w3VD1Vq2c7eTq5gDxS8X/eSMMQkQbXbzhBLL2+ivG6wz3K8t/Hj4dCoyR8kVEGYLsoVy7vfnYN2OCHf/UlXY6g48XDAqvwAKU7g4h/xDpqvZxAENePIX6CW46BxHJXg1qw5yVesLWpm3yH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/BMt0GnCzU8mzxF6XcohRaMyO/Dr+5Tl/24v51E4UQ=;
 b=N1LOb4VSGP/+S1JNmpxBhb9QMuyCr17iDPVEq1bEFPL9hOCzaKoDJ8ovjI62Wts8ZzVVaHp6legTS7SevoQv1raxyS3ClTSAZn5tynsHs5JuAFKOnNsydcYzIX26f6B6Hdlt77eIFl+43LKWywb303CYCQQ13Ijf2BGoGXzKN9+WJlHRLivwWjtnB+MvytWUHAgIwUoQ/Nd1/jm9xZUzYl/aMj0Ol3MjM+9DvwOAO+x/X0/K+FyGnp5a5ITKWsoADR7RDJsN7hhTLqTbSCJY5BWVId5HOTlBeB/stpGJRisx0YxsdPAf1Zq0GBrYCYV9UldQ61fRdi0zZ5a63Ux9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/BMt0GnCzU8mzxF6XcohRaMyO/Dr+5Tl/24v51E4UQ=;
 b=x2dlQLV0wgkvRGa79jDcSWwoPAPfA73RkV8PJmqHMm0isE9aVh2gDBUnfCfce+6q7toURhwipZJIrbTMpLSMag5k3YHmDksT0uDUQFiwhXOyQlnXKEeRYRWyhtD+ovWrFx94GiMheZIGXk5BWC5AWKHux8SnxpBmo7eI+Ioe0Kd6xINuEFvku6D3Ad18hMu8/lp1xVkshXpG+CWC4F68LjKXCvduQHiTjg6bW0jasmo/pao1uPE6EJKn6YCOco6u8qgfGtdnMj70l9RQtPmujOM6+E3YnkWmgB30DbnV/Ws8BCpMjYpdWaafRXxtZuuGZrGs4WOS6aKD92kwaiy+Fw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by FRWPR04MB11246.eurprd04.prod.outlook.com (2603:10a6:d10:171::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 22:20:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 22:20:11 +0000
Date: Sun, 21 Jun 2026 17:19:59 -0500
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
Subject: Re: [PATCH v2 4/5] dt-bindings: dma: sun50i-a64-dma: Add
 allwinner,sun60i-a733-dma compatible string
Message-ID: <ajhjj7FLn136qMmt@SMW015318>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-4-340f205891cc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621-sun60i-a733-dma-v2-4-340f205891cc@gmail.com>
X-ClientProxiedBy: PH8PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|FRWPR04MB11246:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be14a61-8c2d-4f7b-c815-08decfe34272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	eog6abNuApZNeecUvWESk/ceghHozTT7Zmq1es6Y0kXQ9eNro0JMn8d2vgOXoJ2OMYP8djsfUlFMQGALsjiTFlGmlZnrNSMjitYUmHr6oDnTB62dBp//9nH1TYjd3Ij6f0YBB/3JF8AfFhEHil7PVaC9Y/BTEFenCnFV7P5iex/VTSCzaiLD1vITTVwUo+TmU1s9O0mYT2W2YfB3cwtcPbRY5EBoMFVSnqjOslhYkiQBo5TZT6KSHuqXvPMVpGK6QWbaafQ3h2vgMJkielXnT4AYvmpflKvc2UwHuM/i5UZpTWXQAOVVFEOO3a5G8MDQ3Q5Ao6OEDO1kl5NqNtRhO8HHvfIaphmde6TFE/ESlTHPVCW5DL0eGpYP/I+lKGGV/URYWHGi2oph22ZVvaZqaYp85zxCpqR8GL/70PhHNuCOGMSrrhbFeWpOFk7Wd8tL8T8nqgA+KgZ414Ed7zn6eQhdpxN3olANjwVGm2Xegswr93ES+TtjgD/ES4UP1VkX2ILLlNvUa4MUYQ9l0S3a+kFJeu6OUM+K0uWL7/eYywAMniwJ0iabBfuT4Hg1mFKUIvEtsDz5BsmCFd5/G0uE7XRMTo9ZnzBjG6dHfnllZEFdEQtTulvxGUjsM2/OABcxnms0jpFjtPz3f4qllM1Ag+mvooD+ucxlPLSRpSCEkOw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/sCdAOVdNqF7dDDq/Pfv6ReCIWRO5x6xPNr1poxKuzVdm6KbhYEIMBEw5w2?=
 =?us-ascii?Q?pI59Ut++7Vmh/PD6Rbxj95PUf0jwC/kfUHf0U2LukfqwuSBi3vFejIwCHWGG?=
 =?us-ascii?Q?BksW0Ms65ngiAnTzLlXyxVepv3KhtjQRE51jZYo2D85RlmyJVSRKjrtXEHWy?=
 =?us-ascii?Q?D9N2j2OMJYkb5lhzWJbAljV364EhEl4PJaYX1r9rsJZF1e/1nzvxFhJ9z4uL?=
 =?us-ascii?Q?NhK6YheyVHuowAvIJ9EJR22sBez9SD76ni1BiESCUrUf0xreMAdFP7dPwYre?=
 =?us-ascii?Q?tmN5fU6RVubkAgVXyaQRkAymItDY/+maxgoTB90sf4Cu7FAVbV9M/fNCApfO?=
 =?us-ascii?Q?AaCyWPIgP6TEO4qO9Sl1ur+4gyQ9Ii++/kmutw/WmfBVOmP0z0D0zqtfDNxY?=
 =?us-ascii?Q?D/rquF6X8VcXQVuZWcAvWkM3Dkczqsb+8L+YIJV+nd5Cdnogb6NtYyBhWw+k?=
 =?us-ascii?Q?bav+7SBvBy4gxJOTnYO1YfSrp8J/O81p60L8w3Uw2tTafa2St/Hp4hKEiPtJ?=
 =?us-ascii?Q?Nk4KIdpHjVk7fZNTuFmdfx9ax0xQsPRvTcHYCjZfzw5XOMp2mcX9DtLvVgoi?=
 =?us-ascii?Q?2qVpujLUcTONMJm7we3Ewh47FZQWNz8Tz36WJsn5+RRv7G8qxjWM+7cqboqk?=
 =?us-ascii?Q?Xw7cn/x7PsbsPX6I42A+tW/EvpU96u/LM6lEq+07Ua7WqNZSycMvrk8JrFSG?=
 =?us-ascii?Q?lYvF72mEVztsHPmtzjT6zVAl8TsjYgfruPJZgBAZAHCtz+ncR9xNMS1uuNKL?=
 =?us-ascii?Q?MgBMIOmvBpREkYoZyFKCamJf5/CUKp9RC90nvCvzIDbQMdgz1OYKEVIEbJAv?=
 =?us-ascii?Q?DdHl3Q7eMEWwuFJDrDU3eIhoWRF/cKrMpBfzMQDX2o5n2U73PSkP9T/7UTP7?=
 =?us-ascii?Q?V8bohfA4A32f0+NhQr0rjhSzJGGH5byMrW46WZU5egMlXLFvkDtDbopRkn+R?=
 =?us-ascii?Q?U1xmxzCmYDxjDvuNeWt263+eBdZ/Wc6/uzRROUHXCiEB0GYiiADm1hKAHGh2?=
 =?us-ascii?Q?sAfHllKgeg2cI3/w3dOTU8KGdcZ2y7qGCCMqaoASPNBnJ0pSXm2wgOR4LD0U?=
 =?us-ascii?Q?4xyuLP7nmOIhQA71Rd9upKJ+g/yvOZ6KgaZn1A/65KWsGHyVFYOMnXrUYSxH?=
 =?us-ascii?Q?QX3x2aIIi5xvuuiWML8LbUL1134PNFPOlwYN+pngJgHy4lfbWUXEutBjfkQ9?=
 =?us-ascii?Q?jvukRzWF8WF0Lxa7Sb65qvq8K8VSZ/1yzUO3dNznCNhfNOS37i/YL+TL3IFq?=
 =?us-ascii?Q?asAXAWm2b5HCmw6wSnwHrE1/8RaGlI3LJgbl292QZPYh8Vxsu8Tf6RHQyeit?=
 =?us-ascii?Q?K7SHnHPnvlmO35jeyc4JAVbKkwN4fFI75i16iUMbYRJTwJ/weQtIA6Zls7wn?=
 =?us-ascii?Q?Djyp2yCpDSQBxqybuvHdpRhY5kJcmLM5RLFUdZ9ZUHC0Dtkei8VpySnPwsPa?=
 =?us-ascii?Q?DH/Zwux77h/6N4SlQ4VbUFS8Ow2k/n+FCxDJIe6h+BiZS0tVmK3fuza7bw/K?=
 =?us-ascii?Q?YkkYTWmekhXqYVd/fCiTKyrlA19WT7+LmIdvdGiprZpPo2asEKT7O7pxuZ1U?=
 =?us-ascii?Q?NQZ2iB7MoiwejJjNH2rlLRN8pFcWHeXPhQejMrurziRwAt/l9SrUH7z1TpQw?=
 =?us-ascii?Q?wU2O/SBn5JQx84ZnhWR/FxCuac6+1DhIZrNvfz/97nQKuyIPOxFlKetbPxsc?=
 =?us-ascii?Q?C172WNxDfw1KEsGGhkQBL8bbJyWof07QDae8Ue5xg47PL7gVg+Bw6XlNW8bV?=
 =?us-ascii?Q?IslULfREFfPPdazTDYRjWFMwNLptm7D4Ey3smDKD0GY9SPDODlmV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be14a61-8c2d-4f7b-c815-08decfe34272
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 22:20:11.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fPcPvNiFsotW9DFDOAzRO8euBikyT16q9z6h6WRnFPkQQ68STaWkK34Mtny9b+tpe7R8CWFJms8xvEsvJquycHNuEPQ4eypowaWQV51UxgaJyA25FpmHHJSQLim6r1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11246
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11700-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A9606ABBB5

On Sun, Jun 21, 2026 at 09:40:57PM +0000, Yuanshen Cao wrote:

subject dt-bindings: dmaengine: ....

> Add `allwinner,sun60i-a733-dma` to the list of compatible strings for the
> `sun50i-a64-dma` dtbinding documentation.
>
> While the A733 DMA controller shares many similarities with the sun50i-a64
> DMA controller, it requires a specific configuration due to differences in:
> - Interrupt register layout and mapping.
> - Number of channels per interrupt register.
> - Support for higher (32G) address widths in LLI parameters.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---

After fix subject tags,

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> index c3e14eb6cfff..1cc3304b7414 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> @@ -25,6 +25,7 @@ properties:
>            - allwinner,sun50i-a64-dma
>            - allwinner,sun50i-a100-dma
>            - allwinner,sun50i-h6-dma
> +          - allwinner,sun60i-a733-dma
>        - items:
>            - const: allwinner,sun8i-r40-dma
>            - const: allwinner,sun50i-a64-dma
> @@ -70,6 +71,7 @@ if:
>            - allwinner,sun20i-d1-dma
>            - allwinner,sun50i-a100-dma
>            - allwinner,sun50i-h6-dma
> +          - allwinner,sun60i-a733-dma
>
>  then:
>    properties:
>
> --
> 2.54.0
>

