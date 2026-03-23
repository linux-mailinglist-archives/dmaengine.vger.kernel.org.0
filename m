Return-Path: <dmaengine+bounces-9578-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMPVJBiewGk0JQQAu9opvQ
	(envelope-from <dmaengine+bounces-9578-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:57:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE832EBB75
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33CBA3007671
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 01:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A50225791;
	Mon, 23 Mar 2026 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="p/6HjbIf"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010040.outbound.protection.outlook.com [52.101.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3321FF2A;
	Mon, 23 Mar 2026 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231058; cv=fail; b=Xxght7U1+kMfQ/c9y483n3+lG0no2g/gPh02h3ooh7dKWAxc0kEchh8AilkiJrzaiekUCV+2bjflAikkyc81F5a3wMKsxDEQ3Oowm7FXP5PWWKfi+kZ18YdHQrWMsmickzF4iHz0NBr5I3Kp4+FZPFZ4m9cLQv0KWkOiBCkXBlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231058; c=relaxed/simple;
	bh=CBR8NhXfV4a+fOv1aMQsAHDsmLKVwMS7Y+b8eyLC5Ww=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=AHR7aB6QpRIXArncwhLgoYad1jt/fhY/w5WuctS1Bu94ecVIZ0a7Tru9QCjFKuHGYo9kyYolpcCallkFBrBrZw+CISYTzZVa2zAzm06PrzkYpouV0zrKx7HLpdd+6qvkFOou2aJiVWyBOkh7b7tuDE//++/ywKLXIxJ9/9grvzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=p/6HjbIf; arc=fail smtp.client-ip=52.101.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3JGV881ziIelUL7Fji2zenqoRyWljO6LbUzghifdjJaeIj8Ssgtnf9iOYKjbmu4AlbIg0Nbd0uJV+W7XPjjD2xTU1nOiwmJjYLG/COrPX2UjKEm3jShr8ZsWOzvh8vahdIduwyvHL7zyEBTlXoKTR573357p9mO1EXwsv0YSuvZp+wfSaHaX7CDsg8UQ4uuTAFoG55rT3fxQZQ1tanw0mg26zdvurTNrv9MvRAvrW/S9h5AHaqql96MYzAtmhy1XgeeJXsXotu6UDoe/2UgtFbiun/Bd+JDq2RNQLnCZBn2qkPt0ZtgwIg2982gLadILMnrXVfWImx/zb7QVK51kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjHuS8vqapPk0AkWQdjIplEAhtNQnR/2vgaKHuYmu3g=;
 b=r0zeqxXkOllWKjJy0Hjx0PQtWw3RbEuWy4tXvVgQjtm4p1JGmfBdghc5vLjy8rhmtld8ckN+B8fjBVu3y7grbVxBNlAgXCYoWT2jBEIq6qd18HCdU5VH3GKuMIEWwLfYcE6ORsY82X3ZR3L8oP0S4EGC6FE+d125FKvutU70TVO/kTyrxFlpJq0yWx0bJsvfwO6ZOWH7O5fKbi+yT6/kiUfxOh5sn+fTjP6I+rupYE+l+XTJOeT7Z7IbiAEesd5oSZFw4B/VeLAbp76HmOBq9seUbkEVw9koQW2o5ZTMULO/uinT0jey11tSl0BVMKTJrZdHHAeKupF+Rqi66MRenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjHuS8vqapPk0AkWQdjIplEAhtNQnR/2vgaKHuYmu3g=;
 b=p/6HjbIfEVUUJAVSBqKhANARTbCl/O65WIGKwuX+pZld7FcMhP1COp32E4+HUTTHud4yNrIBlynq9PWlxmXlFpFrHPm8bCp5fzxGFaf6HakljsmBqmzDCq7bDZLR9i6gtDEa0WZNUrRvn/jczjo/YiudqoDt0z6qI773y1jgrUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYCPR01MB10054.jpnprd01.prod.outlook.com (2603:1096:400:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 01:57:22 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:57:21 +0000
Message-ID: <878qbj9uk7.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 17/22] ASoC: rsnd: Add system suspend/resume support
In-Reply-To: <20260319155334.51278-18-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-18-john.madieu.xa@bp.renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 23 Mar 2026 01:57:20 +0000
X-ClientProxiedBy: OS7PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:604:257::17) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYCPR01MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc88193-4fe9-41ad-f8f0-08de887f8567
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OIvFjg6Y/1fHOI++Aeeryuu3RFoS4VAHai7IfDqukkTY73/gtPPsbBF6pmYoR9GmjVparnn9+//kyrgxHQLJOKGXNrsDTnVH0O3xRYHZ6e9w3TzDzChG4jY9lFWWbr+qoV2igt6sq1C02Btq7Te3GnHkSrhiDpiCKXssNhV1HxVLZ1yBP/eCXXMNLiB/LugSdu627+PHV6DCtDfl8LTZ6jf/kClptIgO+AACqhFVQbZp5LlRcnVoWRilcYZHyCotqy+gpfOUsGaT9r9x6+xKrZYTYykbV1LoEWXUcpFPSTda71XMo09DJVcfZFhsFPWSBdPY7Ojdl82kQ44VcHj3EirS+DTguBirSCabhb6z3wZoCt0qt4Mj9CLsmbubTCgNQEMGHIzbBdrF6OTxTO1njukrhhTNByVqDfydRlAy7J7L4D30dvXY9mtRBP6vOxymwRUGe7F3q771JiDMtO07Ae/m+pTldOV5fXlZfoDcpkrr9sqSWovkDRzfFQsryHoG70Ted1WeI/EQO4FPbZgU4L/JG6yyFpTugno6lwbPbhAGh6gHy8CQCrhc27h2m3rD5dij7g2THsgzZaj9yyzrbtuUBFx9fJxpK8lQr4w0ixoxSoiVOtt8KyvKF+baeVfP5mxoj2Sy5L/BsXrKqs5RHtwVHJng6nQ7tJiGIKZSHF9JOeLVtkbQhe164tvu8JBeBDY42pueblQrd/27BSBWwOcRLh5VtkgiX6sgBATs7dwE1cp8M4wls8YCcIda5rFR8Y/Ke957JPQoLmOpbsXo6GOOb3ymsjw6i0Q8PrpwHi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZ3T5EMvp35fVLOTDP6JEatCImhRUIapEnlSztCQZ2Cx2crnNbsk7xgQnQ2e?=
 =?us-ascii?Q?cdCJxLNsXH24YU703cDsxiAGtNxEfIUu1TJ4LCt+lQbRsjc8GHtILmNhXwWo?=
 =?us-ascii?Q?ytvNm3rle/Wdw63sFWEW9Cn55l2mOc9ejolnstuD64ehwISWLYqzs6Zbn6Xj?=
 =?us-ascii?Q?/deiUF0L8N7YXg9Xl1DFwy9T5eSF+x83UFLDPNwkJ1c7yv9x4rm1mFelgBbk?=
 =?us-ascii?Q?aIJIaCpT9NHtikzNDnc0P4iqJMKSvvv6UJ8uG5mh5Grvl5OrTIXQXUzElTvK?=
 =?us-ascii?Q?COyVrk72lV3/CzWfhnE5onVi4AanW76HfH1Gw2vtofybDSZnhWzW/FBa2XjB?=
 =?us-ascii?Q?DkIpKlgrIlH6xilDpqBv1APVPE0FQIyCU2CilBOhRHKPpJjeKp+Qd3SVn0Tq?=
 =?us-ascii?Q?d2KFhIURItdMG/mVkhZ3g5ySjZSqDqGsQfD2RRXZM4Vd/hEhPjiaag+GasMQ?=
 =?us-ascii?Q?wpSykdwAxm3iDS8z+rq32SU6lbRiBRjtZo3oevATDexUCaEpOZZKjBXQH9Kt?=
 =?us-ascii?Q?GJjxRG1os4lEXzw4KEEiiYx9DNVEjwthpnnmGuLLEKTMG5dUP+77tDTVLfR2?=
 =?us-ascii?Q?OFnGtSUYDN3t4iZVt4jcEuoK/cqymXEecPa84nMo0ujNYFZZnHklHJTTFH8z?=
 =?us-ascii?Q?CX0Lf3HDGToFysqmUCudwsjKd9FJAWfERXBnoxLnhORvkB1TIHeibTqt0SO6?=
 =?us-ascii?Q?tjj3hTrh42vROH16Ngd8XF2IIoMA/TWHvmLGu729MYxwSuxm98ILNFjx++er?=
 =?us-ascii?Q?gUbbdNVGEWElCgTCVs2vLZrDs3GM+MI0bligBndYvusqKsKbwu+47U4yzfX7?=
 =?us-ascii?Q?09oBzSUIdm7/sMJT855zViF6PzaPFoY8YXm75O5prcH/hX224s3zFwhw6UD4?=
 =?us-ascii?Q?wa1HcWjk69iCz6HKKHSzTRUqHmRSuTXS7IMs21iCBEEkGWfsh28lQWkzWQrb?=
 =?us-ascii?Q?t21i2dlEwB7niACOIrvH7b0NlBIJwqXpBqRQ0kwyw7s0Esb7SnbykWgSOWDt?=
 =?us-ascii?Q?LU2CbwiZ+RpyMuPX0El9AuyV5zDDRKgGxO7ZZQLl0lmAx10tEABM+ACAf3pN?=
 =?us-ascii?Q?Z8OQRrAMtsWofszwE+6IseF2UtiJKLsPnhGfr33Oe9SrIrfS/aX2Bfz9FYLR?=
 =?us-ascii?Q?Jd82wOPFtQoRP3JYy+2yIzdbywKMoNWck2+ai3jFSUfrNfMMy/69PDvk24i/?=
 =?us-ascii?Q?Nj0E9P4ya/ti0IKiMMJWv+hNSuXqlD8X/Jr190idKGEmJlnhSDEmQPBSSySY?=
 =?us-ascii?Q?t317EjBSCO0G6iZoQ9qEaxz+ooYlogaZd5Ejwtq+Uz6b2pvGiOMNFkLAFPJ4?=
 =?us-ascii?Q?E1MxGMSOqflLKWcQnwxzJFntPPfOQTOuosmvvYrpLjMhBRpCe5jUc2OYgJRm?=
 =?us-ascii?Q?6pUez6rT0WIoabuhBoU3q8SRAJvVId/GL0/MeT83qhfh0WeUGSWb1+j20Y3m?=
 =?us-ascii?Q?9d8in91u7BCVmGiIk+YjWGoKnGY35kUBrmpvoWrz0FfNiVRiFEyrZHD4lxcr?=
 =?us-ascii?Q?/SjDlIdOPGKUupV8/UyJ16XU4uq8OM31L/tFrOA0EzHXwYBGh4ggtHo3nqi4?=
 =?us-ascii?Q?fbJr/W8IjGCtLU/yWqf0ogyWbMrNjpCC/eKH7Tnf6yQskr7mBTMIWyJ6JyHm?=
 =?us-ascii?Q?qlXSXMuBpkkwAuV/ciygZgQXDhZnI4hw3MHEI21x9pFOmdNOtRieT9KGPhti?=
 =?us-ascii?Q?ATjmKpmftwxwOle5jWjbPbbn6aiZk08AwTftNrTq5hpyoHtOufSatTZrs0Mb?=
 =?us-ascii?Q?GBu7dpmbpNYKt9uc2h/LfQA4TSWSWofKdxIkOBml0BxdMjjx1k45?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc88193-4fe9-41ad-f8f0-08de887f8567
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:57:21.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPe8pd2RrhSP17TgEdFmLJADu0ThLXfdcT8eTFzdDii5fYZ+GMlGwKRg6+x++lB+wa3w4hVytmQxKg/9sHhixITgjjWdHYZ/hF+B3QJplybExEBxhLHMwka5C/Z5JKp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10054
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9578-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:email,renesas.com:mid]
X-Rspamd-Queue-Id: 3BE832EBB75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

> On RZ/G3E and similar SoCs, the audio subsystem loses its state during
> deep sleep, due to lacking of proper clock and reset management in the
> PM path.
> 
> Implement suspend/resume callbacks that save and restore the hardware
> state by managing clocks and reset controls in the correct order:
> - Suspend follows reverse probe order
> - Resume follows probe order
> 
> Note that module clocks (mod->clk) are left in "prepared but disabled"
> state after rsnd_mod_init(), so suspend only needs to unprepare them
> and resume only needs to prepare them.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---

If my memory was correct, besically, all mods (SSI, SCU, etc) will be
called with SNDRV_PCM_TRIGGER_SUSPEND/RESUME when suspend/resume.
So they are basically automatically stopped when suspend,
and automatically started when resume. see rsnd_soc_dai_trigger()

We need to care about ADG when suspend/resume because it is always ON
device. At least on R-Car.
If you need special handling for RZ, you need to care whether it is
R-Car or RZ, etc.

>  sound/soc/renesas/rcar/core.c | 108 +++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
> index 6a25580b9c6a..eb504551e410 100644
> --- a/sound/soc/renesas/rcar/core.c
> +++ b/sound/soc/renesas/rcar/core.c
> @@ -962,7 +962,8 @@ static int rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
>  static const struct snd_pcm_hardware rsnd_pcm_hardware = {
>  	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
>  			SNDRV_PCM_INFO_MMAP		|
> -			SNDRV_PCM_INFO_MMAP_VALID,
> +			SNDRV_PCM_INFO_MMAP_VALID	|
> +			SNDRV_PCM_INFO_RESUME,
>  	.buffer_bytes_max	= 64 * 1024,
>  	.period_bytes_min	= 32,
>  	.period_bytes_max	= 8192,
> @@ -2059,11 +2060,70 @@ static void rsnd_remove(struct platform_device *pdev)
>  		remove_func[i](priv);
>  }
>  
> +static void rsnd_suspend_mod(struct rsnd_mod *mod)
> +{
> +	if (!mod)
> +		return;
> +
> +	clk_unprepare(mod->clk);
> +	reset_control_assert(mod->rstc);
> +}
> +
> +static void rsnd_resume_mod(struct rsnd_mod *mod)
> +{
> +	if (!mod)
> +		return;
> +
> +	reset_control_deassert(mod->rstc);
> +	clk_prepare(mod->clk);
> +}
> +
>  static int rsnd_suspend(struct device *dev)
>  {
>  	struct rsnd_priv *priv = dev_get_drvdata(dev);
> +	int i;
> +
> +	/*
> +	 * Reverse order of probe:
> +	 * ADG -> DVC -> MIX -> CTU -> SRC -> SSIU -> SSI -> DMA
> +	 */
>  
> +	/* ADG */
> +	/* ADG clock disabled via rsnd_adg_clk_disable() -> adg->adg */
>  	rsnd_adg_clk_disable(priv);
> +	rsnd_suspend_mod(rsnd_adg_mod_get(priv));
> +
> +	/* DVC */
> +	for (i = priv->dvc_nr - 1; i >= 0; i--)
> +		rsnd_suspend_mod(rsnd_dvc_mod_get(priv, i));
> +
> +	/* MIX */
> +	for (i = priv->mix_nr - 1; i >= 0; i--)
> +		rsnd_suspend_mod(rsnd_mix_mod_get(priv, i));
> +
> +	/* CTU */
> +	for (i = priv->ctu_nr - 1; i >= 0; i--)
> +		rsnd_suspend_mod(rsnd_ctu_mod_get(priv, i));
> +
> +	/* SRC */
> +	for (i = priv->src_nr - 1; i >= 0; i--)
> +		rsnd_suspend_mod(rsnd_src_mod_get(priv, i));
> +
> +	clk_disable_unprepare(priv->clk_scu_x2);
> +	clk_disable_unprepare(priv->clk_scu);
> +
> +	/* SSIU */
> +	for (i = priv->ssiu_nr - 1; i >= 0; i--)
> +		rsnd_suspend_mod(rsnd_ssiu_mod_get(priv, i));
> +
> +	/* SSI */
> +	for (i = priv->ssi_nr - 1; i >= 0; i--)
> +		rsnd_suspend_mod(rsnd_ssi_mod_get(priv, i));
> +
> +	/* DMA */
> +	clk_disable_unprepare(priv->clk_audmac_pp);
> +	if (priv->rstc_audmac_pp)
> +		reset_control_assert(priv->rstc_audmac_pp);
>  
>  	return 0;
>  }
> @@ -2071,8 +2131,52 @@ static int rsnd_suspend(struct device *dev)
>  static int rsnd_resume(struct device *dev)
>  {
>  	struct rsnd_priv *priv = dev_get_drvdata(dev);
> +	int i;
> +
> +	/*
> +	 * Same order as probe:
> +	 * DMA -> SSI -> SSIU -> SRC -> CTU -> MIX -> DVC -> ADG
> +	 */
> +
> +	/* DMA */
> +	if (priv->rstc_audmac_pp)
> +		reset_control_deassert(priv->rstc_audmac_pp);
>  
> -	return rsnd_adg_clk_enable(priv);
> +	clk_prepare_enable(priv->clk_audmac_pp);
> +
> +	/* SSI */
> +	for (i = 0; i < priv->ssi_nr; i++)
> +		rsnd_resume_mod(rsnd_ssi_mod_get(priv, i));
> +
> +	/* SSIU */
> +	for (i = 0; i < priv->ssiu_nr; i++)
> +		rsnd_resume_mod(rsnd_ssiu_mod_get(priv, i));
> +
> +	/* SRC */
> +	clk_prepare_enable(priv->clk_scu);
> +	clk_prepare_enable(priv->clk_scu_x2);
> +
> +	for (i = 0; i < priv->src_nr; i++)
> +		rsnd_resume_mod(rsnd_src_mod_get(priv, i));
> +
> +	/* CTU */
> +	for (i = 0; i < priv->ctu_nr; i++)
> +		rsnd_resume_mod(rsnd_ctu_mod_get(priv, i));
> +
> +	/* MIX */
> +	for (i = 0; i < priv->mix_nr; i++)
> +		rsnd_resume_mod(rsnd_mix_mod_get(priv, i));
> +
> +	/* DVC */
> +	for (i = 0; i < priv->dvc_nr; i++)
> +		rsnd_resume_mod(rsnd_dvc_mod_get(priv, i));
> +
> +	/* ADG */
> +	rsnd_resume_mod(rsnd_adg_mod_get(priv));
> +	/* ADG clock enabled via rsnd_adg_clk_enable() -> adg->adg */
> +	rsnd_adg_clk_enable(priv);
> +
> +	return 0;
>  }
>  
>  static const struct dev_pm_ops rsnd_pm_ops = {
> -- 
> 2.25.1
> 

