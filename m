Return-Path: <dmaengine+bounces-6721-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA09BA8005
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 07:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B123B8336
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2829ACFC;
	Mon, 29 Sep 2025 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0g07cX5r"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F229ACF7;
	Mon, 29 Sep 2025 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124224; cv=fail; b=Qybev5FbzJ1m5IFYZRPNJWkUfsuTjzBc4FvkttDEbTF2+Jr0QNUVuS+/YkrWxTUY35v6C6qXHVggEDp/BDxhJZusvZtjMYfJeON2QX1AXunIMldDhXD3D/uLqyBHymyNtXl+qQpruCl/nckuH8YIkDc2d1En5AAcTPjtXuwFlFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124224; c=relaxed/simple;
	bh=uwXL637iTkxCh/4yHK4nfim8Vrgo5r0fsTO2tPvD8hk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lfsj1I1PKHsY7cwdSREA/pJsni4yJJmGVGPo2qmYG9oMIYJyRUzHizynoWZ2o2HhsqEeeUnXSYNuVOxEOS0zgaaBZbKH7gV1ylvVzvH+vnUlSItPDJNwDUqdsFuFthz4I1lV0tPAk98fwynbJibMsWzmfL66cbubZ+MiGaqJwyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0g07cX5r; arc=fail smtp.client-ip=40.107.208.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZdvBRHIReKfyuwT9j23OJF8hzpDC6d82qCEJslrnO56yylifmD4qEytkv6iVWbL5YOjSLJ6wCsrEcwE4mc+e6pJa6s8lrTDQp0BBE5jGE1BU8WeH5FCn0PA2/5zMs5sRDYGgu1IYdLKoN1+obhO0nbr8rFvBy02YowGqMaGlLqMkOIjqu2z0p/3aiiPInNies53s2J90JMlb0+0fyruILfpGFOwPG7Kp1PJC1u+I3N2PhC8q9XLO9k0LpM9dT0sDoTVEHOBZNRKZ1do5uBc61CaKjZKkOFAepCW2vyIJK2/rrMObhnTmltW/hYIsMhZr2SifB1mhaArbj5OyV/V8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H773GghB59iaLVCqgdbkSh6KdK3ukTHO0MgoUBVYou8=;
 b=JqRzo3ci4l62Xnx5qczOVRvITPaziRjULS92m0eWhWlsSHhIeoTpFxu6zzQGzOT2DuohPNP1f179u/4GhDECUHtXEZWKt2vDEZ2s5S6oqDWJE2VWgHu4NoM5xdADhzxdHVF60xbfozSH+hZ9kumV6akLBHZtf2PQUdTV6/ojxH+FzcscbVr+Ljz+05AaZEYzzAnQHtNcCpGCgLINayhNbLX8qg7+vMYQeNeR8o2H8KivhVJB5Y95wVx2zBXqMsUwYZhxkLQiWCrzmVIfCXuTAfTR9QFHkeVyOJzZcIDPaoKUQCCY/D69+B1/PM2ai0zReGsSASz+zQR6PCUw6B2hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H773GghB59iaLVCqgdbkSh6KdK3ukTHO0MgoUBVYou8=;
 b=0g07cX5r87t89/BWHdC/kMlp77Mmi8X8LFU24Ti/XA/9eT34a88BJX1JpGyZZvWPnS6M3u4VBgKOc/gUyA6rx3PSvTN5xImGA5VfOo9THMT37Hqaqd77k+FM/DD78nVXPCax/N13i/OhAGzbj9gDsbZs6cO1AISNk6+JIbjJTLw=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 05:36:58 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 05:36:58 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dmaengine: xilinx_dma: Fix channel idle state
 management in interrupt handler
Thread-Topic: [PATCH 1/3] dmaengine: xilinx_dma: Fix channel idle state
 management in interrupt handler
Thread-Index: AQHcJ9gPk7EbJetffUKQ1IMMmS1EErSptfbw
Date: Mon, 29 Sep 2025 05:36:58 +0000
Message-ID:
 <MN0PR12MB595389852415C5833530F1ADB71BA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250917133609.231316-1-suraj.gupta2@amd.com>
 <20250917133609.231316-2-suraj.gupta2@amd.com>
In-Reply-To: <20250917133609.231316-2-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-29T05:35:12.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CY5PR12MB6058:EE_
x-ms-office365-filtering-correlation-id: 6d2b712a-6d1d-4ed6-5e5c-08ddff1a3553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AGoyMCeQLhsM0q4z/tuGVb8/OmZuVwFqHXmjUdLn932LCaN71uOZh4kVRl2y?=
 =?us-ascii?Q?TMU0sbB8BOn2vwdeejaj2BM0iOMV8+bId0mmJHCeT9WpY6auKBKsmb4P7H+J?=
 =?us-ascii?Q?Gu29bNojuneUFxHsEweb8QEHItLtu3un6mM/Xe8hfgj5dRK++V1YC0GBLKWY?=
 =?us-ascii?Q?L03Muu8MmnlOuiqEwkmEai2AuOlXG64t7roVSIE2/3KBSUuxTQbHBdruhQtT?=
 =?us-ascii?Q?crGRAtHsgQw30FtQW8lh9QWYh0WOLtBQYcrveYY5STtT1B1973AYJcT4j0/e?=
 =?us-ascii?Q?PfjkqmSrqox9/l19Nr16h3QFIadLA4NRaNRAlTFpoR+ABe/U2WOJ08wLb0KC?=
 =?us-ascii?Q?NanaOr+pF5b0MiaaPWwr8wxr5Egb/VZj8hLf83QlRTlairmwxkx2MpLuyd4L?=
 =?us-ascii?Q?o5rOsLI3nUGWQGILWeNjM+osNPiPLMWHWz2FZrxaGzmcHGKwQftrmmCP7beV?=
 =?us-ascii?Q?iptSeSNjLNOtTtab0Y8ulPt1arJAiMrWS4PwcG202t21O4YCVrb3qX/CwOGu?=
 =?us-ascii?Q?rFPE2e22+R/g7T6qwiuQkGWDWfwJ+4GkiofCluAxQoSF1ym4jH6d3M37GyKF?=
 =?us-ascii?Q?HaLdgh0gCVgzXHilk7BZHbULqMXz0xbRaeUwF7h/OypLRfxDZYpg7wiSB2H2?=
 =?us-ascii?Q?LgVDXGrdLMozhFBSS908o7LxK9Um6eCSq63aZMyO6K0SBNWir3dfKmScOpKF?=
 =?us-ascii?Q?HTpiEAKdW72SDt9MZlh+ATJDJsC0rjEts4DhV8fCaKO/2rkVRD52/4gAZs/i?=
 =?us-ascii?Q?MXjonaHoBWrDg8hNLE7drKZF7yzk7N6+S0p64yW2ndUnX528MMgdMImqbJFR?=
 =?us-ascii?Q?3N3AW6j1XFRMyI1im9sgVWUTYrZIOPt9nbRmECntReE0Wy1KumE41/EeQ/Hc?=
 =?us-ascii?Q?N2TfOEHPZmBH/g9eK0Rok6JB0plfrkwLfFQXEODJX//9qbFziVUld+2D9O7s?=
 =?us-ascii?Q?6Wiz6IFPizB2nCAWiJsfeGwmQ7F18aVLmjpkHjB/FljJGfybIhA8O+JIdYM9?=
 =?us-ascii?Q?5hCkT9q5WKeOdcYrqeNLHem/RNmlV8t0LecA+e+J2FRQavK76efDq5gtaQUT?=
 =?us-ascii?Q?cf0cUqBJQDahQN6W54eMZezl2bGnc/Ze1xXu6sXKWrd3iPE32hmdRwFfJRDW?=
 =?us-ascii?Q?W+0V8gOwF8txmo1V4ygZt2mb79TR1sNYoCP2r/A1EyeKFBRWHVDQb6Q9jau5?=
 =?us-ascii?Q?uCmOw9wrrOb4uhahB5xMeIZWYHbEoa1zcxRd9r3HFbibA+n+h/3ByA2EN6b0?=
 =?us-ascii?Q?zD3V9Nz7qvpgRGYd2nkwQOvJchtQXv/nTinkMz/f0C03RzZRLiKWbsTzuHao?=
 =?us-ascii?Q?0VoLtWaJ7C/pn90gUArwmnqDHxYZPu9Aua8AeC5FSITDUIrl8zIwJwMP2OvC?=
 =?us-ascii?Q?6Ikk0VLHtSMpIX0406FQ3IvCaHYkxTUZ8qmvd0sE9VZKmKH0JQZ9uynMo7cL?=
 =?us-ascii?Q?ID8A6LU0diNEbyaLj6s1DDul/WYdjagWzfzu07/26hHoD2lp7Z0INf4TIAGk?=
 =?us-ascii?Q?X3HBteADAX2YnHRjfOE5YO75dDKShHL2qIWw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?luEZ8+CFqZS5mTl/t9J1kLkPZQLLhhZxr6mFAuLHIKx+DjuRRaNnuLrnDiwj?=
 =?us-ascii?Q?8rM05GKg66JTUbc/IjARcf+uDCbszF0xJt7cSowwG0oQGqcHJ9NX5pDKP8Ab?=
 =?us-ascii?Q?wyqCsJIXtRh+tmy+fitJv/J2h3AiQVHwI2mjnN2AJHABS3ihgBJKKTINGypX?=
 =?us-ascii?Q?J/px62xQJQuyUwpDPlCsXMUw5DXJIBdekmOwTms2UqjDnWK+Ja9hzeQRhvnh?=
 =?us-ascii?Q?XrXTU2z1fYsqXs1DPCC/S+Qyqqh47mWgup9Oa/r+84nDHWoZIkMI3+b4GLql?=
 =?us-ascii?Q?jbuOEyow7nKbIsgzqHAFMngyccwK6DqpuQXWBy69LPprtZvIBEfslPMdXkW6?=
 =?us-ascii?Q?MmEAhZEJYHdqQxj/kuDj42UmAaNOZ+G5vXVwTTp85tLavDaLebGU9iUuz+Qj?=
 =?us-ascii?Q?zcLQdJf2ak4WPxXsnvewdc8JZlV8slZSmlXdxTk4YleQJApAQO6aKtEIX3/L?=
 =?us-ascii?Q?TVLJ7LkhDK+vU+6bNRYYle0Yl8LLcNJM2RT0tq/Vv77rXr8gsnu0YrPgGwNa?=
 =?us-ascii?Q?Jp8d847UdgagDVaTzb07S0pCczJsxJaIAUIJE0B6MQBfQvIdyTXjGF6Kwo5T?=
 =?us-ascii?Q?qE1aiHJ9J+GcMlvKsUIuZM1zHEaH9Lp6Ef33EvDY9UE/5dCriL/dGfMoPUBr?=
 =?us-ascii?Q?grbAYQU/BjOUXcof0bCVWGlcVJhFjWiMA3ajs5wkkSkYHTDZ+BaeBpOrs6LU?=
 =?us-ascii?Q?MMOteJl+Cg0hwK6x/nb8cQuh5Gnzow4UxwIBjW29sBSCxV/KbnM65VM+hKPl?=
 =?us-ascii?Q?PWshzPHTwv/mUxBeFltR0SsKq7ULf7MrkmrCozALdvfy0TYd1OMFyD0NKUeL?=
 =?us-ascii?Q?ZLLnTMzR/ISIl8pTzCZNehfA1znEquofJS/ruG1zHKjxAEnOu8k4ySGa+CAf?=
 =?us-ascii?Q?cn+8p1903Wcrn0sCLgIoGs9WF+amvpn0MOzBm/Dn7n5DkaBvVOxCrFZqKCL1?=
 =?us-ascii?Q?V+U8i5sIExGCSWKFXmc52/09qDAo4ZqyQqBUTkeqAnpcEKH9zNnCbcMMTKhh?=
 =?us-ascii?Q?cupd3lv2e7pdGSbo0x6jYrDRZuwThMsD6VG3CW74viMMrraKfArXgII7ytNV?=
 =?us-ascii?Q?Y7EKA8Zxi5Zu4Nn6BhfZt7BosLL+nd6Na4iDN9QljqpMe7vCqM0W6lRvVVri?=
 =?us-ascii?Q?QmDiG2wVcyUJHCf10piFbf8BBW7g3mcMfaexMB13MhB+pkx3esvGeDcZalr5?=
 =?us-ascii?Q?jF76FBqEf2vAACC+62SkeTNqfbu4XqpSV5wTwBgxArIu810A8VP+oruLW1k5?=
 =?us-ascii?Q?/lkqUQyxxIUw+ghIoli4XmXdo77Ew7qAghQOPBM9aXIW+p7Y23xcm6sG4N2m?=
 =?us-ascii?Q?jRzwB0ZEtPmngzIDAGGJGA8xG0omxzPcLAJoK2fsJtz78BTFcdce34HahD1L?=
 =?us-ascii?Q?87GK7aKOcPiNEdckOiH7mb4dK6LFSF+Nc5O/117KAJtGsWJAUiK8GOJ/EN4W?=
 =?us-ascii?Q?872nL08agwYRm8tEblAXvc58C+TDC2Nzp9PZNocXIJIF5fKlsddxrJXrIz4P?=
 =?us-ascii?Q?uwljIh4VaX/cRleJrZ4X8IqRro30V7cZRhx+6WZJ/I/tYIYL932ZPMGgMDzy?=
 =?us-ascii?Q?vHLydqMbvhFZ82OyaLU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2b712a-6d1d-4ed6-5e5c-08ddff1a3553
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 05:36:58.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnSc8JiHG2RCPdgxbktZ7XRw4ps2RHUG5KYuRFOf5dvA+G2ecVNOzkCJyFs9Q9lK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Wednesday, September 17, 2025 7:06 PM
> To: vkoul@kernel.org; Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> Simek, Michal <michal.simek@amd.com>
> Cc: dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org
> Subject: [PATCH 1/3] dmaengine: xilinx_dma: Fix channel idle state manage=
ment in
> interrupt handler
>
> Only mark the channel as idle and start new transfers when the active lis=
t is actually
> empty, ensuring proper channel state management and avoiding spurious tra=
nsfer
> attempts.

Nit - also explain the spurious transfer scenario so that fixes tag is just=
ified.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct =
Memory
> Access Engine")
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c index
> a34d8f0ceed8..9f416eae33d0 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1914,8 +1914,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq,=
 void
> *data)
>                     XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>               spin_lock(&chan->lock);
>               xilinx_dma_complete_descriptor(chan);
> -             chan->idle =3D true;
> -             chan->start_transfer(chan);
> +             if (list_empty(&chan->active_list)) {
> +                     chan->idle =3D true;
> +                     chan->start_transfer(chan);
> +             }
>               spin_unlock(&chan->lock);
>       }
>
> --
> 2.25.1


