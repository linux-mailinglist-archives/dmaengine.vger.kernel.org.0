Return-Path: <dmaengine+bounces-7346-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14468C88415
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 07:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE853B0775
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 06:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881F3164DC;
	Wed, 26 Nov 2025 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B7VW4fa+"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303373161A6;
	Wed, 26 Nov 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138197; cv=fail; b=mqr9eZ3fkijBdXL4aKnWOGo6C43c82aeW6HU+ePfs3m5tc5OwsUBvMdCTErdkiIixoR9DFUbrHho4Sg/lj3r/noW4sqJbREAYAg1zcKMmLrsqCwKg2jUbgZ83vB9QxNIKEXZ1M/xo/u5dOwa0tr4MWBWacuf66f1/cabcHC/YhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138197; c=relaxed/simple;
	bh=ICl+5tZLfNRgYwAANTSIvhQeKM5kXZ2SMbmAYeRXyoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GkCOgxEPRfPWKcMAZo8bAUL01APa7wLEtEvNYm/kYW2Cu5DX4A5oChVHz8t7xLMG98i2xEVPkXNWdnhEtujyqjorGof+lndYhy8cKkoZgSTNs/DP+D4+2PblOyVTRNl8dSIsy+odj6nFzR3NDPwnPVzZHaZwHKs7ssMvQQWwAZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B7VW4fa+; arc=fail smtp.client-ip=52.101.61.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym+HckwRGjB1QBix1/r3U+cgDqSfU7DIdZ7WDE7EQ2Ck2GOtrX7Tr1BB7kCifwfxzkmso1dAg5zASy9/XxZSNNGfjwGLbUax9AkFVs5dUGzo04X/DUjs4vsBZmCUCRZ/jqTe53QJG3sl6gLqLRaYmyg0BFWTp7MYxaUGc63qYdh0DkYq7HKUXZhgLRqKp7m32+0jjDwt4ME9xbjdNtAKkNO0oVIg8Q4NwGlZpAWIuOdDYc+J0sN6h7Bx87TVeopbkLKO5cOdEWutN1kWtgQ9VZrvf+D0dCiBGJtnfTuOSkBdml4XCByNsC58uD5Rr62jxTLqaSuPND1yE6puxLWuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn2cQW3RG7LoZEPE3YpPkNrxY2RF2SwFFfyXbC/li30=;
 b=Iq5mJA9IUxaluGkX0t3wWx36Jbx7mgChOsh2gItMpMhjh8p1bY+MJINbnKrtrJeEZNx8Q6KA6Bz3bOnyFOAQAlTiKgYX9f52a9DKKsnDyCk/53VDbOXTHjrxiTsMm7lgzi5ipLMk1Z7TQ+AyaTem6Ic+EBjT/zH9H189GuATZHM5KQvHsACYqeczZotKCkZ+V9Hzd2zTlAbdx3mgX651xFUN3YcadfgAB0shNZvTUT8pgg5jj41xhKgRQulnNCm6z44OSr+qn9nEqreJwWo8vsmLY5txawQDu+yS0Jy5iTlvuclReTApYO63k4pZEvtTBsKtsavTcN5cbvWyBT6GhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn2cQW3RG7LoZEPE3YpPkNrxY2RF2SwFFfyXbC/li30=;
 b=B7VW4fa+JzXqDXpnuelzKvp4DjXXE5nDBh6wj44AwPAJh+YfEj/vLiDXmpz3yLK1JXJeZ016SwDGgLWoes+wz6mY5pH/ceunNac82qUwtnS4DaeZF8bN1YIOEJ+SKnTlTA9V1SdT61AikiRJ/6fQ3Qa3sJFMZt9lGK3e1rgnWFQ=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 06:23:13 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::8ccf:715:fdc4:8a14]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::8ccf:715:fdc4:8a14%3]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 06:23:13 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND] dmaengine: xilinx_dma: Fix uninitialized
 addr_width when "xlnx,addrwidth" property is missing
Thread-Topic: [PATCH RESEND] dmaengine: xilinx_dma: Fix uninitialized
 addr_width when "xlnx,addrwidth" property is missing
Thread-Index: AQHcQrjodwqWjLqA/0OOPed0tpbls7UEtIoA
Date: Wed, 26 Nov 2025 06:23:13 +0000
Message-ID:
 <SA1PR12MB6798C7AFFCB21EBC21B6C8F5C9DEA@SA1PR12MB6798.namprd12.prod.outlook.com>
References: <20251021183006.3434495-1-suraj.gupta2@amd.com>
In-Reply-To: <20251021183006.3434495-1-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-26T06:22:08.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6798:EE_|CH3PR12MB8353:EE_
x-ms-office365-filtering-correlation-id: 273b21d7-e7d8-456e-f0a0-08de2cb4472e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YXoKJ/OqMp1twXbQyQWtZCEQ2iLbvjq52ITrPvBGGx7+jQwcKHypInM4hjzH?=
 =?us-ascii?Q?sjkRFRr26MNp3vgRLqHQ5jHKZxSrIQGFyuleuPKRYI9+2jTLgBlg3zPCt/wW?=
 =?us-ascii?Q?c+4KB6HHOCHwE4EScOj27XvW4UsKx/mreXlDOM0woAPQIU4EeVSK2lHjvCSW?=
 =?us-ascii?Q?z0bQONI6ZB8ffYI7hvoOFGEBAIofOQBnh0OKe3pmT2l9FYA72lFmTZBOizCP?=
 =?us-ascii?Q?pQKy6GVn7SVP/xI4Loj8GL/gki5+oDRucEkD23MUn7IKw6yYCPTmYUR3ZqsJ?=
 =?us-ascii?Q?yLwk5OhtV82NriaF0faG+zO5n3Zhup7MxoEr3kfWUdGxfqSyowc6jXZDQuTP?=
 =?us-ascii?Q?/CxcNTHhIPovxZyNCrdUmDmNaPGBFcPuMYkpM+fVR0edfIwrpxS5U4j4SPRY?=
 =?us-ascii?Q?AZuQHEEiwh4iEd19BgGUZ5hzODs/whDvYdrRYEVHEAnqppW3/cZj12SG+5cW?=
 =?us-ascii?Q?zBzHK0PM1umHe8uENue7PITgmJTaZnjbI3rbwOblLiNVwAAmTL7XgswEL2Wn?=
 =?us-ascii?Q?fkC89bwwa6QMn59egSD3JJJlpI0x4pi9by5mSCK/jVgBMhX2J6pjxH01FsmU?=
 =?us-ascii?Q?kdQIiZS3XvJMHI0VBQDeNkOhHPBoY5A6qYu4DsLY+5TJaEoPvYYErD2Q/nt9?=
 =?us-ascii?Q?MC8pa6lLWvXWEMmS7dQ+qAreChe6WhOhFf+YvO5/F2ruHDILovKLNU9Rur1R?=
 =?us-ascii?Q?RjyLe4AvVQtfy4ZkGZHxV97xXHALQQeU52GIXtOVU38l4N8KTGLR5JCcd1AP?=
 =?us-ascii?Q?etLjyF6Aya26xLW6LQJ4ERguShtvH9CLXD2AtkNEr3MF4+6ZmWoo23YIkKgs?=
 =?us-ascii?Q?Me80bzgbMx8Zw4ViYq858S0jcTuzNmix6PszFF6wmNbu5fY5JBDO/ePU7GoZ?=
 =?us-ascii?Q?6uq/iafy/khGrX61CSEmk8yWYPB3F6v7KFToM6h83+1Ddjj8TIzRhV266wke?=
 =?us-ascii?Q?a0h/omq/oyI5gNrez+Qy0oHG2tG7XQKKMWQzY7PvRK5rmPg1UOks2OQJKx+t?=
 =?us-ascii?Q?WzNY23bbw6yYnVWKPig+hcgxe4RUOO9HxJEE7f82Tq0HqTgB17C1XdWOlRCo?=
 =?us-ascii?Q?0aSNAXiG4mnloWT/fV2gDQMSTwHKFY28CNYi4+/13QLggdrVIwd5CTYJ4NdC?=
 =?us-ascii?Q?wrNhGh0SNApDvWV7FzQuauIfLYTwl2OL51XPwLcFjCFMF+8jniDKQsZW2bh2?=
 =?us-ascii?Q?miVrtHHdXshiiKv4G7TPl8IqXgCqOdlhDaiCZkGeky9trg6AsaJVkVh7VXCd?=
 =?us-ascii?Q?ggq7IffOcGodMubFVakMuYNiN6U5wrnsickx71EVPMYq5C/kjaOty7g6gwb0?=
 =?us-ascii?Q?Bf1P492xbXKdp5vbMoNoBtGLywlJS+YBQcnf1rri8VNqYUuhC+O8uZYyQlfH?=
 =?us-ascii?Q?NiUn/AyQOmWDm3p2gT/A18hp2ONLzjzu5oZYPBquOKYsMLpvn6ZrR5I+Ta9s?=
 =?us-ascii?Q?No7xhoTwCMezfJ/3pyYFq5zPHt+b9xs5C+8kUaQXEX3rfKTxXIbgRf5V/zhG?=
 =?us-ascii?Q?wBF8HcUOwzgB/ap1HmFTTwatvHVDtz4cV+Dj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gwpWFdD5ge6FT5ol1qNTmsQMEEITNZlp2qY5f52luxN24AxgENDNfVb+tD9v?=
 =?us-ascii?Q?eneiZCcxaqdPTmY3fwj7TNIP8NfdEnM1IPy0TiHfKe9rVLL113gPyOmlHYZ8?=
 =?us-ascii?Q?QEs+mjnRWU8QfD5l2cC4TYXMDwzdx80+SaUCmezcXOdz+LbloBaR6pFNpbwP?=
 =?us-ascii?Q?T583uYup8PdJvyQ26l04jj/2engexf63LFgMAhJVWUQW9J6QpKLTZMn8aueW?=
 =?us-ascii?Q?uxXLqrWfGOsJdJ3+vO49ZZd3EEqS5rO19pEB5bRIdosCvV2Sq3nyt5IDGO4b?=
 =?us-ascii?Q?xlo630NJwDdR21kymZk5/3/Vj66Rcwi2g0SC9YILNH50kL+LK6XtIZCvl+qd?=
 =?us-ascii?Q?clL2mSirUg1RcK7y2+Mf8DFKUsPOxsC2tBCdgg7IaIAHU50oEdH44m8Kg30P?=
 =?us-ascii?Q?vjRKRVaAJvF2iYV+Vk1BmxIFIZKR4plEDcOtHelyT6CHqjvcZggqRN19SlXN?=
 =?us-ascii?Q?ZPcTncAQyw0XV+IHImCwG/L4hzLVxi1jiX47cKRl1C4Q9/CXEpTuqZzA/ZbO?=
 =?us-ascii?Q?t12d3jgwssjgibn8dJ/su+xS+tapfw7Krv/YjxD4C13jji/mavICtrgVuH5I?=
 =?us-ascii?Q?WODZ5T8PfcA/c+q4NosmUbsItM6MvKUgU1wyqyhEeGY87BNjR9MuonwdTnB3?=
 =?us-ascii?Q?dUPkdhc5lQvWEluMTm7KaOYK/l63rCZ+mH5AQGcAnZjvyOD/Od8j6YYwMpYA?=
 =?us-ascii?Q?ee3EdwoqygaT74dlmdi58cuGbYvdGoU1Wxjs+4pbl0/I2B675SObzWkyUw/y?=
 =?us-ascii?Q?2l/JvruK9MMiJZhRxMypNb8HHW3st64kpD1Zy68tLn15TrvsyOEJBfFp2oFt?=
 =?us-ascii?Q?ylXMz+ww8bGvs6DK+SsB3FPS8Nu8vYkGNtp8VFgloh11Pjxep0HFnyRJ6ROS?=
 =?us-ascii?Q?e3dHYHJyk8+jPdLbhCjJnegQwqqb1/83RpiKqOXfCGi3uPn+5sH4xhLgaK9O?=
 =?us-ascii?Q?Wr5zWA8tHO/TDfA5bQ9cAhRKOgAHRu1cHuWqhRIQi8K72HvaZmxQFTsPBY1T?=
 =?us-ascii?Q?OZ73QJ8jjbhSDVHYi2RarbHFKB/fLzIN+kAJ2erDDLntG97znK2PgA+niCqM?=
 =?us-ascii?Q?nhpxmZJ4TeeyzK12tHW8H8sTGVBztlW53UpdJcrLb6Nbg7eaq08e/OzYD3nH?=
 =?us-ascii?Q?JavjlLn0KtLpbDwY6t5vh2OICz76JL0kB4GMpx02LLqlwOCEBLhh/mWpMI0L?=
 =?us-ascii?Q?c1bpvpnYpqHOhKGyOFx0hlkmsOOgpD/l80tI4mFHeLjW2JT5/r9oSeSQxA3q?=
 =?us-ascii?Q?KR0HNlV237sSenhpM1ufyKMxNyEoE7/owwf3XlHOELwkHMMM5JNaOSxDA+77?=
 =?us-ascii?Q?J0zD5x5LFF8Qg7kd+PCFzgEVFNQRH7AF49Wj7wTJRt866JpDx3fwjfpD1nzX?=
 =?us-ascii?Q?VUXvb/9EQLr9UUd83/qOKrlS55Odmq/wgsxyaGKptUNsCjT3k6XxCz2M688U?=
 =?us-ascii?Q?weeLuCzazuUm2ZOTVeJ/N7ew1C+YKV5EWUGuNt28KbwAPHt602jUZyZGX85G?=
 =?us-ascii?Q?NlvpMdXhU9vpkDm4j+v0QabHPuwOTGwwAPVJgVZ1DExZ38MqQ8DpT91jQBpr?=
 =?us-ascii?Q?MVApDdvLboDfXWfhm68=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273b21d7-e7d8-456e-f0a0-08de2cb4472e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 06:23:13.2905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9ukrbMISZoYz52029I1JEFZzK53rUxpXPcwCwo1AsOp+YkJKZqrqf36YQhiWbi0Uu+vekeB6eZdvMxvHKMCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

[AMD Official Use Only - AMD Internal Distribution Only]

Gentle ping.

Regards,
Suraj

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Wednesday, October 22, 2025 12:00 AM
> To: vkoul@kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Simek, Michal <michal.simek@amd.com>
> Cc: dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org
> Subject: [PATCH RESEND] dmaengine: xilinx_dma: Fix uninitialized addr_wid=
th
> when "xlnx,addrwidth" property is missing
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> When device tree lacks optional "xlnx,addrwidth" property, the addr_width
> variable remained uninitialized with garbage values, causing incorrect DM=
A
> mask configuration and subsequent probe failure. The fix ensures a fallba=
ck to
> the default 32-bit address width when this property is missing.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Fixes: b72db4005fe4 ("dmaengine: vdma: Add 64 bit addressing support to t=
he
> driver")
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Reviewed-by: Folker Schwesinger <dev@folker-schwesinger.de>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index fabff602065f..89a8254d9cdc 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -131,6 +131,7 @@
>  #define XILINX_MCDMA_MAX_CHANS_PER_DEVICE      0x20
>  #define XILINX_DMA_MAX_CHANS_PER_DEVICE                0x2
>  #define XILINX_CDMA_MAX_CHANS_PER_DEVICE       0x1
> +#define XILINX_DMA_DFAULT_ADDRWIDTH            0x20
>
>  #define XILINX_DMA_DMAXR_ALL_IRQ_MASK  \
>                 (XILINX_DMA_DMASR_FRM_CNT_IRQ | \ @@ -3159,7 +3160,7 @@
> static int xilinx_dma_probe(struct platform_device *pdev)
>         struct device_node *node =3D pdev->dev.of_node;
>         struct xilinx_dma_device *xdev;
>         struct device_node *child, *np =3D pdev->dev.of_node;
> -       u32 num_frames, addr_width, len_width;
> +       u32 num_frames, addr_width =3D XILINX_DMA_DFAULT_ADDRWIDTH,
> + len_width;
>         int i, err;
>
>         /* Allocate and initialize the DMA engine structure */ @@ -3235,7
> +3236,9 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>
>         err =3D of_property_read_u32(node, "xlnx,addrwidth", &addr_width)=
;
>         if (err < 0)
> -               dev_warn(xdev->dev, "missing xlnx,addrwidth property\n");
> +               dev_warn(xdev->dev,
> +                        "missing xlnx,addrwidth property, using default =
value %d\n",
> +                        XILINX_DMA_DFAULT_ADDRWIDTH);
>
>         if (addr_width > 32)
>                 xdev->ext_addr =3D true;
> --
> 2.25.1
>


