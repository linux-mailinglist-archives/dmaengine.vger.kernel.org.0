Return-Path: <dmaengine+bounces-9637-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BVNEzU9w2nqpQQAu9opvQ
	(envelope-from <dmaengine+bounces-9637-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 02:41:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E584131E58F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 02:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D2823049250
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 01:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAF26E708;
	Wed, 25 Mar 2026 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="iFSCD+nJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011023.outbound.protection.outlook.com [40.107.74.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B02066DE;
	Wed, 25 Mar 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402866; cv=fail; b=aMPcucP7191Y47ufM/dXLpXvFPVxmI1S3o9pF6jMdhkJZa77r1GzDZTYX/eeh9Z2gRrD2Dy7R+QSddATbMPYkh7LgHnsZnOp27RXFRUOu/eVeAIUkf3A24vy4sGZPLZYlV3+5pO9Hi7+mCei6DPKWQFqHkmlaHFZ778gb7H+JE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402866; c=relaxed/simple;
	bh=0rlKfZGuH2y0J0eBtnEisMDJZb6ZWTKQKf/gcMOdUnE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=EX1XUTn3hMd734Jse9Q2EVa8d3a7IWtRFf/41l3YffaY0EBx+qmkvpBo6CNcCBnEkCjib9rpwCIjFAlaDpNQ+tWHQVN2GwbPjiPwUmslq6mG6ejIhzTufILCLdKyq1DPZQYxYoTB68c2HuZpODkyFCndyI1YqE08HAvmkj4RWXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=iFSCD+nJ; arc=fail smtp.client-ip=40.107.74.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c61+UbpSTlm4oMQ1MlXn/UiQq+3ao21eC2XyN2G7oZgEb8i/InZpRR60rUknqWtKodtruSwRqzwEb+M7ooam/PXpGOqO9dCAaTcBTSDNi7gYJ2tFCTx8uvicZ5KrkdkH9RyNOmAz66m1kVR8snuOTYjJ3BYnICiBIPi0RwbfIX2uvSwOg/vFtptG7BhYzP1DSZ5Z+ye5eyiu6o7u64t0VqCRAcMYAEyOFXEHlK3vfX8nTzpia8umGfOvTz8d9wmsKeHxSIEBWmdhWx+Z5nvSAt3vZtEx/IpUWpHlZauUVKcZa/URRuRhZgyBstJ63zeA2dVSVIHdf3AmzyHrBE5Buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMqHfz6CPM2RF0SQRTL7hnPKH70exQN6wlGADDTDlRw=;
 b=ZIIqIbCT2zIRZeXSkRUXRDtkOz0K6U+piFC35praoVREntwTeHRA7GtuRqKvNrlrmdXX4jFcCsc70dcVqIqHPzu+sQk3SFAB62vJORCJBXJZgv0F6NJgzeVekLDb9mo4SGkjg8zhKTZg1oJEThZihrKeKOtHt9yf9zM+mI+/6OTrk/tpJOtLDf+zsBHzLHOwTTBW8hQPcH8lXSBIigll2uVjiaKwvqSEwjCZx2DOC84gLAk6JEL0xxqYzIv39Z6uEY51AdUiCQ0oAx5BsHVs8Qr1+uOb1CRu+txIS0I499luWVrw3nEkMvaqXPMF1mGI39pOTDAWOSVUovdApQsg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMqHfz6CPM2RF0SQRTL7hnPKH70exQN6wlGADDTDlRw=;
 b=iFSCD+nJR21txLPcIqI0KvN4+dY52O2KBPQ6bo0u/60yr4U2pSxwkuRbS1CeSyxi3wgI5UJ9lakm3n3gKrd5RxJDovY100MT/s1+bhg9Z34f0MJXdpSIUrboeNDMvzy7q+jVQRBdtjikIrk4kgL8YEGPAfjnWDfsbRJyT0Dzsfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TY7PR01MB14310.jpnprd01.prod.outlook.com (2603:1096:405:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 01:41:00 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 01:41:00 +0000
Message-ID: <871ph8ptxx.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH 17/22] ASoC: rsnd: Add system suspend/resume support
In-Reply-To: <TY6PR01MB17377203552FF28EB7DCDA071FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-18-john.madieu.xa@bp.renesas.com>
	<878qbj9uk7.wl-kuninori.morimoto.gx@renesas.com>
	<TY6PR01MB17377203552FF28EB7DCDA071FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 25 Mar 2026 01:40:59 +0000
X-ClientProxiedBy: OS3PR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:604:da::16) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TY7PR01MB14310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1e0ee9-43bd-49d5-51ee-08de8a0f9148
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WBfj8YRhZPyzio+dX9H3zzm1N498aMKsZ0ooM/8E07w82OkAFVMsSAG9+7HPN4om08A5//A22iCRdQda/IeeZiBA3qugPVdDzjzYV/DBA/0JUhwSozIlZ1XsAcq9yq386pm6eGS/ehpI/XgHWzK1LTakSRa+sxEZ2S96ZjR/p9O/nb7VaNpv7ooVASXYiV50Fi4jfK6UWz1q7nGr4UcMe5bbUJlQJp+tu56DvP7tdyj4CU/Nw2om7GEWn9lFzaziLmFjmmOQgu3h3xdedX2KnLxDVi3MJ2JpyTxndNLISwu0+C7R1lYS0SXduqtOtM9uILAS/HI0ElDU9VoOgqP/FGVZSj7zXkqrpIE2e5hUTePF9ejl84Or2Iz8sOpIfkX/SER0TL42T5QDpwpISbLq9lPVdPqAcDV/PDHIfYuFWqPL68gNOR16twz1S3hR4g3FgQINzq0hDdypajNu8Kp4Xf/Rvb0mx3W7xXp8P6dUdivSZq3IFJ3cZYqQxTrB3+ta+nrpnSYZb7pmb3bSCBNj+IweHkibtuhJyhUyHihyf5yqMBausJCOW/YVUXATggxPDkkr95HtnVEEaJ7AmL4RhlJzDUumU3IiAkW2YF0DcExGYpEyqVYdX+g+3Leq5gVjy2lLTL6f5qTML1E+TcnKI90YcyqT+1EXhBWrrT2KVdqFtZ8PWUOCq5PLNBHsf6xwmbFnkjJl70xSTHB0NmDl4F6ERhp6BwABPoOitRpKrkLnmkdhOrqoiWYsaETzHFSP0nF1ZErJbw7vLB9S3huAQcVa2ke968PWdk+EXCCYKmc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wiucwtEph7IshiNAguRv+V3hU8Xd3BH4KwfWxXUWTdo7Ta2ek/t4SW0zgAPU?=
 =?us-ascii?Q?7SjHq5iw08j80DhqAxMlz6JpVmDbMwP8okfkhDoyPMjCqBUCY5IXLYoykFpa?=
 =?us-ascii?Q?foj/0Q+t/OlEe06bWwzT/bMlg+gfk7oBx38nEzKYFPlRCW5zALu9Ikbh+/HK?=
 =?us-ascii?Q?wfngWy50d0PKXOW09U0j7nSVm82LYY39NBKZPgG/YqesG0lGZAa3/OnoVaX4?=
 =?us-ascii?Q?BSKzoCVl0fVyd7oRYeEcFd0QWQo10/qYzr0IdgsBQhRRxBq2lOgDgtiuGXPy?=
 =?us-ascii?Q?OapeXZiBXhGiBmJ66222I1S1F5De6SYA7P/8EV2ffsZXvaPYyTniJFT9Ae+m?=
 =?us-ascii?Q?fI7kW8fA99OoufGPErqc9bOmB91zaDPCP+X4qm4ZppfcL448nnSfE/thWHS1?=
 =?us-ascii?Q?wjQBy5rBs4bv7fBSrOstdkP30gC1CGQghQb7rwrjH7cekK9287u5GhcCxBEF?=
 =?us-ascii?Q?xSFLcreAycYDBSSxOKP+sNiryels2+iPKfL4Ltkv9baprHILNvZN5QOblIce?=
 =?us-ascii?Q?I6Lum5jXbDc2g0suak2xjpeFQs8IJZhJbz2Qrn1atClYneUnXvv4vfWY1cIe?=
 =?us-ascii?Q?/0sMeE7c4Eqbk8NCqjngvSkQ6B7jMn1NG8ZyV6rmzBLN2efi9Btr2h0QlUB4?=
 =?us-ascii?Q?3pBc/f5bnS0O3rxAmt4WGWtMILr8N7b2Atq1NmsFRSpfoDNpTAC2eHtX8t9C?=
 =?us-ascii?Q?1mBVWyiVWr/zLmYyR8eGVCe0p+jUZ1bDM4rRAXOTDzTCS+tplUwWGUqD26Fh?=
 =?us-ascii?Q?VRO2GemNCFn4tNPICSb0gACIJSMWIg8y/jnvT2cLNvciPGLGAQKNNhhwrz0f?=
 =?us-ascii?Q?u5tJqZOTHrW4BFPBnc9D6VF5tyQCXjv0u27GcfOuNp+vzlAMXzJwMvOT/lB9?=
 =?us-ascii?Q?pLgEzNynnWd4XucyfoYs986lADs71iH+5xCk4PQRYYRIB9j+GpuMCLy2xMwp?=
 =?us-ascii?Q?h6XKID08L6M5DTp2dVg04+8h9dajsEQy3A3kgQDDpOS/3zQ6h3DqT+bhdwQa?=
 =?us-ascii?Q?k2TqYW0P9yJHYdsFRMfarVxRd1bEg61DtWtM2iJxXTyZcimXP/1ytCR6Legh?=
 =?us-ascii?Q?rLMk+V4Vm5o8OOqWAHkeVRfNjCIHz0/vhQZT4+1SDTnik7QXDk4uhgBwo5P8?=
 =?us-ascii?Q?KkL1Ii/QjT6B44zj7e/5vrBJ7rfkOA6UVZRAG7LgZ6ZF6paLKFWl/Dfztgb4?=
 =?us-ascii?Q?fDATxWWdHWboMtKHdPqMG+GNU0it0B5M68fCt7UTRC5gxvAcFgoUCSp1BRfZ?=
 =?us-ascii?Q?NhRUJXi2TqrmdQMshqSAM2zVbMuKLYnw1qFehJ3Qx64doRrgXRP68NEXGZkQ?=
 =?us-ascii?Q?TlWjEwLyzh8JDnB/qrN0mrgY2CwYiogrzXXLAeWdXLHFhaXl9+2Upy5IPVje?=
 =?us-ascii?Q?l4XECi0V0qWvi4MsqocvoX83etZ9m8dRmCVjmtbi3lzuPU72r0AtRbVXWA+b?=
 =?us-ascii?Q?UVYZZn0wWaY/corKvecxCYi8zHCGbXBh94GO8PK03HIZYZaeMX8w+JLkQe4R?=
 =?us-ascii?Q?tZXICRdREPURd02/IzeBZADpBddhSBg3pV5tK8yav71DQVaVi4tLjzQs8DIJ?=
 =?us-ascii?Q?Y7HuVgSC5Hm837fm2+MZ2mwbZwuG82DPQ9W1jiWL4XfsWPgdQvDCNnfyVw4Y?=
 =?us-ascii?Q?JSaCo6FFtjyTN/0c7/j4nxwx7Z56Kd2jI7s68Bg9/hEFRi2aI6+ZycD3IX60?=
 =?us-ascii?Q?3JMDZ4J5lp1REOFzgNbw7s0tX7McMiEJOkjgtWHU2OrdjIpgnA9rOPykQXi/?=
 =?us-ascii?Q?LhR2Ycn9M8C30AC0sd6Af76oDLXJWj/iCQZs9VX9ppqk6XgX3gHI?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1e0ee9-43bd-49d5-51ee-08de8a0f9148
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 01:41:00.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URYAIdabXtjv+Ywtdw+J45WK98u7FMiRL9PbshuniSUTD9OcmLYlQSMEPut1zS5URR8QIYlwBA7Y8YrMWFO2bpFtq+U3Bq/lkfoeX20bOf4cBz2oz/N7wXFRf997VJjo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14310
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9637-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:mid]
X-Rspamd-Queue-Id: E584131E58F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

> You're right. The ALSA framework already handles per-module stop/start
> through SNDRV_PCM_TRIGGER_SUSPEND/RESUME, which calls each module's
> .quit/.init (and thus rsnd_mod_power_off/rsnd_mod_power_on).
> 
> So the per-module clk_prepare/clk_unprepare cycle in rsnd_suspend_mod/
> rsnd_resume_mod is unnecessary.
> 
> What RZ/G3E actually needs beyond the existing ADG handling is:
> 
> 1- Reset handling for modules that have reset control
> 2- audmac-pp clock/reset toggle (infrastructure, like ADG)
> 
> However, there is no need to make these changes conditionally
> based on SoC family as the optional clock/reset APIs are used.
> Do you find any issues with my approach ?

OK

Since we have separated files for each modules, I think it's beter
to follow that style.

This is just an idea

core.c
	void rsnd_suspend_xxx(clk, reset)
	{
		clk_unprepare(clk);
		reset_control_assert(rstc);
	}

	int rsnd_suspend(struct device *dev)
	{

		/*
		 * Reverse order of probe:
		 * ADG -> DVC -> MIX -> CTU -> SRC -> SSIU -> SSI -> DMA
		 */
		rsnd_adg_suspend(...);
		rsnd_dvc_suspend(...);
		rsnd_mix_suspend(...);
		rsnd_ctu_suspend(...);
		rsnd_src_suspend(...);
		...
	}


ssi.c
	void rsnd_ssi_suspend(priv)
	{
		for_each_rsnd_ssi(ssi, priv, i) {
			mod = rsnd_mod_get(ssi);
			rsnd_suspend_xxx(mod->clk, mod->rstc);
		}
	}

src.c
	void rsnd_src_suspend(priv)
	{
		for_each_rsnd_src(src, priv, i) {
			mod = rsnd_mod_get(src);
			rsnd_suspend_xxx(mod->clk, mod->rstc);
		}

		rsnd_suspend_xxx(priv->clk_scu_x2, NULL);
		rsnd_suspend_xxx(priv->clk_scu, NULL);
	}

dma.c
	void rsnd_dma_suspend_xxx(priv)
	{
		rsnd_suspend_xxx(priv->clk_audmac_pp, NULL);
		rsnd_suspend_xxx(priv->rstc_audmac_pp, NULL);
	}


Thank you for your help !!

Best regards
---
Kuninori Morimoto

