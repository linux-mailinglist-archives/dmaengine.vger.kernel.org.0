Return-Path: <dmaengine+bounces-9636-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAxiJqMzw2noowQAu9opvQ
	(envelope-from <dmaengine+bounces-9636-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 02:00:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD8431E293
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 02:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B87F301DE16
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD579218845;
	Wed, 25 Mar 2026 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="XJgFA6Ah"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011048.outbound.protection.outlook.com [52.101.125.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316D33E7;
	Wed, 25 Mar 2026 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774400330; cv=fail; b=H6wMoUmRENaWtrL9Jvp2DEJqSlTitdZrWvpGEIsqhs6ZFHmSqxyel2SgmhsExEgo0CGseIKTdmezpzTGeSjywoKG2thUaDJfHZPuczHtr2+Kq2F2D7xWDwT4cV1ycaXVXpNHblYUegcuaXhDk5W4I5GH+YZpe5STOa1SwzKRYV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774400330; c=relaxed/simple;
	bh=C+MldcBCQsViHQMSNykcBYxqnpvlEWBIvVtwUQGka7Q=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PyN5uJ+XmM1Rc6rWj6yYqWt4BwMKPVt15s+wunqdxCGWzj72h4rIbTlCyDa8XX8kaMPEGhzvk2i3fuh9np7Q/tlCd24g1vzC9caIzcdBhcq+zjkDdWn3YlNS192EeF/6bTgcsigFlcnXG9TYJHXnVK1bF4sonLzHKQ47UmQ/ygQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=XJgFA6Ah; arc=fail smtp.client-ip=52.101.125.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ5Kw9zvftF3KGPAVCsH9qc/tsHKg3iKOyrVrrW5pMdPrOAc8hOw+MPUhaudTNV4iaVzo3Uj30x8V5si383pbKQmzqs5QdLxku7HnIQ9n9R7Xbay628sjt1uJre0G4jtY70sONQlVEtYoAD0QmQhyFOj5WsWm6AiHesNms+JZC3bhaLXr5nXEAJWQNJccNKmd9bkv4w2A5vEGjedA3bvAYUQM7nqsvGfFYSzdDLrG8ME0wLdZeIyURhN6UwPjz0Qi7Dx50apIZ4epCqc2ak8P+92BQQbLWup6OhFD7lkcgdlOpaeDnYcJ/8JcqY/pK9XHHX9jEvIYeW3/fZ2XbmIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud/LBhM5bWdKdXV/0PtA/0LlxtTalJW3+7+6mdcuTUk=;
 b=rQO9v1xU/9usUShX7cxTUp2HKk5rRvSBid4eXAo65AXGli2IrF/R6y8reJl7pwD3BWNJy1vWMlyPWj7UE9sx9dB/I4LBEutwRowbdyl8mr6BaqItDg5A4sZZ1C4Hk3pZyql4XWKnCAMzmAI2WoFlZkwLjfZ1yxR10dPkAbGRtbMbkekqGbvB+QkHZwtQgMTIMJKXHThqpUB1eAMFxeXIh4htDZgZVp0MyETMOlwoGiBxROb9kavoQrAe3Vt2oWl87TeBD5gF/hVTTce+C7cG8oetRGj6/7CUyxTO9XEvdHgasC6/D7QorrLIKVsB4ttw8BDl4BX6pfterKWZElEn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud/LBhM5bWdKdXV/0PtA/0LlxtTalJW3+7+6mdcuTUk=;
 b=XJgFA6AhxBTStBGQVh8ykHi8g5s24evZy61BngrL9/6nf+3LoU7LSiOIY0DdyTki80rH8hBHEdiexLhgUA0ThC9U5Du+w21i7YKsSftInRfQbUgBRxvQ5n+GvOS3gIFi+S3iUEj4CVfpTDf2q/knxLwnIlfHonbgTevWoETcXHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by OSCPR01MB13258.jpnprd01.prod.outlook.com (2603:1096:604:354::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 00:58:45 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 00:58:45 +0000
Message-ID: <87341opvwb.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul
	<vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring
	<robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Michael\
 Turquette" <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Conor\
 Dooley" <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood
	<lgirdwood@gmail.com>,
	magnus.damm <magnus.damm@gmail.com>,
	Thomas Gleixner
	<tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai
	<tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"Fabrizio\
 Castro" <fabrizio.castro.jz@renesas.com>,
	Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu
	<john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>,
	"linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for RZ/G3E
In-Reply-To: <TY6PR01MB173777CB90871A8837834EC94FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-11-john.madieu.xa@bp.renesas.com>
	<87jyv39wuj.wl-kuninori.morimoto.gx@renesas.com>
	<TY6PR01MB173777CB90871A8837834EC94FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 25 Mar 2026 00:58:44 +0000
X-ClientProxiedBy: TYCP286CA0356.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::8) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|OSCPR01MB13258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a659985-6344-44a5-92ce-08de8a09aa3b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Mo/Jy56OQoZoJbqP+JCzdVwkfbS3Zhg+tOTbNk/5nsym1BFREz+BS1mz+xpU2GHqbaqzsys6r1C7f54njZuoqgplMhqWOSEDO/lL2EQOMSJBbfbGbpt3Lh6atpVXbm0rVtZAGKifPXj8ulsfUiXn2lWNy0pmalIuL6/Cd3r2M3EKqz/zmOgkLDa1f93eVcnBpxslW84zm0w45Z+EJ+KXqACXq3lyvzJHpe0qAu3xI8BZgQUHzpp3L6vBFUq45gQaLL/d82aErpksMb1AOG5dLm//M3zZRWxqTQpXE47F10qCySVYuvfQGukToRDw3Y18BtDUPV75OFVQgNxmj+hiORVphecB9HIaCHyf4O3LYNA+++0y9BpJ9N2b4SX/A2CFLLKhH8E0HEo9aycwrg7VDYGOyJMEYMxGZpR5fbRRwgsZwhYxKvwJgmPuWL/YhTIA7K/GizWKUDhI8cAfYRiBE1BmgqXPxq2XS6sP46ih5LTygr8nCCSJ4nB0B2iPnx9ThtGH6jOcxz8L28/tJI9B6P4p679u/+4fydyo7m/AAo5sfzzw0B+xeJ5kLPdfvQuDBeGZJ0v56zulMviDytMOUGxX2mF3qdXqUHRD5/OHsPXKuloUrHv/w9181Kgj2Qyzp9O3bi3INFvqx8yga/appQHjbRgFSKpGkbKsSkXtgk8Pl1aVLjRmLOPtCwntkh3Kpr4CXmYF5f+bRkzxcFyQb6JoTWTY+d9Bm3RjGAiLJFVxY21isLSILUPDmhgu64XiyeQM1w9HVsm+PHrNYETWUD2JN/Tev7SyyjoYs+G0q3g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+1q9bnDcvkxUcZ5oDeuAsQGPCvvDttX1jnPHcL0EPMLTLz/lsmdVvChINYZ?=
 =?us-ascii?Q?PubTaXdMfXBdaMKsBc/4N3y426NfxQgMrWR2yyvNqVgNCyvwbvOynwavoip/?=
 =?us-ascii?Q?QTwasqkS/wynH/JE5HwjEq90jzy+8jngIYweSXjhjmRmrg9dL2NtGfnBAHU1?=
 =?us-ascii?Q?59hatQXFEoRNTDNowuDYxM7uXusZuD48uXjZAPbGmxFLfC03O0o7tgUs7zIi?=
 =?us-ascii?Q?6HSaKiPkECWNCwKidM+7ezerrBXqd4zIIYOh+jlBbTjazUi19SQfHhul/64Q?=
 =?us-ascii?Q?6bMGnCV6t03a82dAYgxAyZC18ayGVzFG+vLGUVL7AQZK3+8E2T4QCMRZl6aA?=
 =?us-ascii?Q?gQcj47b6UuOwbEFKymRcIJ+RkcEdvbFd53Fj0aOhkiRNB66oy3klA1ox98o8?=
 =?us-ascii?Q?SZfAnO8CKtslNDVxWd8xJXW2uKRbWNgopmT+FrfT88bvbj8OW+fgSursipAR?=
 =?us-ascii?Q?QfVxpvoGf6r8EpHtmjchDVz38gZ9mIqCVJuxD6AXQnWC9Luviq1ogd9iOdtu?=
 =?us-ascii?Q?IlCiRLs18Q5APVPhwJMvhO2sxbV/kvvT3D5+67FGpt8Oj6XbU5hewiEOgpMe?=
 =?us-ascii?Q?UeIpTEtSCljkgRTey0UEc9Q4ZM5mZjlcB+i7qHrj49YeL9ehZU1cmFiY5Aj2?=
 =?us-ascii?Q?F+t/Unt1LmiAVz/mRycwmHTWQKIPdAusUE43YLLyF2fa7Vbi8WV6JJDgp1Uv?=
 =?us-ascii?Q?7UrGw5e9GXKmuDKScVbkeT1aYiFD5nw6WaGap1/lNSWlTwKAIYP482PJhhh2?=
 =?us-ascii?Q?XG+NCtSklNaJie0UgCsc00wkHE0FabHEgsSIUkJLejobaX6cmUcpEwsn7WK9?=
 =?us-ascii?Q?k62ppn5uTVUMQTZBDpRXMOR6ufFbkdLLNsZqBi9QlphiUS1QqMURejeVwH+C?=
 =?us-ascii?Q?B7DnxYKe10oK5FRTPWSMeEnHQoC1nVma6qzbl8YhQpcIhmMvNSb17so8RUzt?=
 =?us-ascii?Q?zJvn6jgK8qOTfW1S1yXH75LAtmJ4qvvKsd7XBVIfzDvyhDpnV4rINS+FWrJm?=
 =?us-ascii?Q?sOtVH/t8BTG40vsohyIBiJv3FYrhw5Cx7ffZcvSNnckw60UnOHj/s6JnX3xG?=
 =?us-ascii?Q?FQ4fljP1UaH1eptpBuJeOg7q4j1cw9EE2NffDcvS6dztcY2ChmPe01rydP0W?=
 =?us-ascii?Q?SuACyQN5m3rYsR/t3aZt67TyVWzFIYS2slGYkIVP42XI+Jh8UQyZTSvxnDnd?=
 =?us-ascii?Q?LkRZ4gUU4czN1XfJHbjunqvDmjx48lfApHchlxGatm71ElvBvscHQOBfxVp5?=
 =?us-ascii?Q?6oMVhTK1TiW2yU3K3vVr5DFA7Xwe6ipxT3f+Cx5D39KetAZQZ8lRca7J25V8?=
 =?us-ascii?Q?YIGTxX9qkJJvEavAWXGpVl65rTStWNAETvqqEZXf4MDCSTu6gxmetPcnPFqh?=
 =?us-ascii?Q?rp98GMqYcnW7I2RI2zJeyd9MetTEYfj3aLbKRnd4+XGocNsQ/NICOG7Ywgba?=
 =?us-ascii?Q?d/uzfUK9ZCDG7FwE/llPBmuD+cghxlwWsGdgfMgKx+Q50nrYpXc3H5codA+f?=
 =?us-ascii?Q?B4PjPZbvWCT39F179vSyjqBXTYPoivZHBMSdjVTSZ1obKAgt3Vl2sSBSth4O?=
 =?us-ascii?Q?fLdAsb+ScAU53zBpyrUaffTZDHOVIJu6uNFwNYqFmtD1dK8oxLyoquWg5Bt0?=
 =?us-ascii?Q?ENq6soAm8JvFzdXuvxC9capVzDsm9Nu+4MG8hMQU663kOsMn7rZUjdoL0L2c?=
 =?us-ascii?Q?gYtADDn8bC/lcfSFLU/3Fp35i15M4RYJX/JZ95EYUeOab19Ddlb+ohLKXl2B?=
 =?us-ascii?Q?kI6VBP8P5heU94TerfhTHOYxBav/hZxpak8tMd85/EyLN7w6k/5b?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a659985-6344-44a5-92ce-08de8a09aa3b
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 00:58:45.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl02TLpJJjQ08Q0ND2UNdIUe9+mFomRw35Pfp2zcmQf93Qtg9yI5vt/Et6kIfQP0bOH+YDzGhsZMWgwhX5KwSPsGqngQW8aUPrx7ynJKdm2riKhy1uTMmTLHLKBWgpp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13258
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9636-lists,dmaengine=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:mid]
X-Rspamd-Queue-Id: 3FD8431E293
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

> > I think it include many features in 1 patch.
> > You should separate it into each features.
> 
> Agreed, I'll split this into separate patches. One for
> RZ/G3E DMA address support and one for audmac-pp clock/reset
> management. What do you think of this approach ?

Thank you

> > rsnd_dma_probe() is common fucntion.
> > Is above possible to keep compatible with other SoCs ?
> 
> Other SoCs do not need or specify these clock/reset in DTS and
> the fact I use optional APIs makes it compatible with these other
> SoCs. I'm wondering if you meant something else here?

OK, nice to know

> > And, we are already using "audmacpp".
> 
> What do you mean by the above ?

Naming. It is reg name but we are already using "audmapp".
Using same naming is less confuse, I think.

> Regarding rsnd_dma_probe(), I intentionally used
> devm_clk_get_optional_enabled() and
> devm_reset_control_get_optional_exclusive_deasserted() - these
> return NULL when the clock/reset is not present in the device tree,
> so they are fully transparent to existing SoCs (R-Car Gen2/3/4).
> 
> Adding per-SoC branches in rsnd_dma_probe() would duplicate the
> common DMAC setup logic. I believe keeping this in the common
> path is the cleaner approach, but I'm happy to discuss if you
> see a specific concern beyond compatibility.

It's definitely too early to remake it.

But please add /* for RZ/G3E */ etc on top of comment.
We already have /* for GenX */ comment there.

And, you added the code *before* /* for Gen4 */ comment,
but it should be *after* that ?
It is handling priv->xxx_audmac_pp, so maybe before audmapp_end: ?

before audmapp_end: it is for dmac->xxx handling part
after  audmapp_end: it is for priv->xxx handling part, etc.

And I like priv->audmac_pp_xxx instead of prix->xxx_audmac_pp for peram naming.
Because it is easy to find them by normal grep.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

