Return-Path: <dmaengine+bounces-8465-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IYJNoCFc2krxAAAu9opvQ
	(envelope-from <dmaengine+bounces-8465-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 15:28:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D165770B9
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29826300F28A
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0929283FC5;
	Fri, 23 Jan 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EDI8RMZo"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE230EF9D;
	Fri, 23 Jan 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178413; cv=fail; b=N0BautTd1tkd3UDPqMXXg0aBqQtk52DjlS//iLJJG8ROSOl+ZDVS+si77+sdU2eO5R9YKPMv1CdYLbx7txEjnvhkcw7FR7v+zpNeaXwAjMLebIMme85YVoAK5V+6ra0FHX1jcf3HKUa5tk6MaGGZzB3Rhbm4/fJIWL4lU+BdFGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178413; c=relaxed/simple;
	bh=jBO86LdjV5oAN+ePG8tDtPfMTJYz+H+NyUYgSC78KQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8SB9Hz1NiGsCv0Lhmh5WqgjPvGpml5ZhdweEIZE/fcxg7Eu+ldVKZ07Alnyqt6qmZsaoIQAHaBNAlY6vA0ufYG1cCAL+vgU0mFtB8UtM708gMPcxszQEvVTk24FBGWAlYDWDfBxYLatRVq9PNJyIUhThQwjD+5Zp2sTTOvudhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EDI8RMZo; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS7SwkWfeN+DcLScKeSlD9FEM6BergB/0Ks0zqXjrOsYF/oUjW96mbSn82fHrSdNZYAfepYYUiFZJZkB4K+6PJNwYuFKpjN2Nk99jICC9QMX6sjc4czj3rNtEu1OXIzq5oGTKtJcxXq/e6ECulajeMl8gWBF/XokSy2AH3eHDorUfMEmEBL+EmeVcxf8IRpF2JJRTofYIdNlRGULimge9io/yqrWdPS9DLu+Tz+s59k+qg/uu2ZbxXhmgEu8bNvoKwnsXqctP3srMzs9FsFslB3nAAdvncRk04UWvfSYy0AK3+hTsf6/ZUmTNCsVvcEwMICMxosRCsJc2q9IZjNUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGYNXWx3ZrBep7jXLtDFkHUrKTh3NJhsFO0FNf6V/yk=;
 b=lWDA/4X+o/d+3sNWghgdPYt8OFc9jGuUCH/6LWPcYZ+DLyZiYuYKveZGPyFZDBxQFXdX5sLkHjvtfSFmTOG02K2k9VRHGckqPud27Bb2k8HXgLCS14RIwyjCcWxrQDBYRRV0nYiRi+FKgPaEs8wJ8EoTKc7USjdv0the02unT+H+SzGmstEVI/fQ+85NkpcxgAAT+t470u7rpcvMyyK9AIZOJU3+8gu4EmejVHpoR/EimDr5FYhTMq0f2wwD+CFPXkK4O7IfmC1Lb5KcFT4Ho9Q0ECuNSklIG7COWBQxocE9P1ZYr3YFIs0MPskIkspEsSNr5QkvNlcFmlMK9dc+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGYNXWx3ZrBep7jXLtDFkHUrKTh3NJhsFO0FNf6V/yk=;
 b=EDI8RMZoHwaft5kl8HgnqddW1sazzmtXBqs85WYHiPJ1Zwxv69JdxTXqVRdDKzTEolGPixckVu17jfUO3Ns4CtCTY3Ud8dCr2f+q/wQq1DXz9ag9zZrXZBeV4d78MpiWdcn3ANaAqgNHxQCs2CnZvNHWIEVsxB2rPenYHgEOw10=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 14:26:48 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 14:26:47 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Topic: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Index:
 AQHcgWARe54h1fxwa0KhQPOEEiCB/rVTczOAgAWkE2CAAJ8sAIABQA3ggAHz2ICAAtugAA==
Date: Fri, 23 Jan 2026 14:26:47 +0000
Message-ID:
 <SA1PR12MB8120661263F6B1202598A3439594A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-2-devendra.verma@amd.com>
 <aWkT/TDoLNnGUNlG@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E8E85ABE669FD626E75D9588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5U5AoUkE2uCzaL@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D50A18E90DEACF2B2E419589A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXEEq5SvkdFYgG9z@lizhi-Precision-Tower-5810>
In-Reply-To: <aXEEq5SvkdFYgG9z@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-23T12:32:37.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|LV2PR12MB6013:EE_
x-ms-office365-filtering-correlation-id: 650c2210-50ad-4c7f-9b14-08de5a8b712d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3JdISLXbn4jUS0FohxhPGWSLsOQw2JHnQioBM2rAbLNiOi7xuIL+RKfBhkOY?=
 =?us-ascii?Q?7GmFZrfVE5OMKo0XikDNqYbr+wjy7PI9Gpz0h4kGdX3a6sTvrUjyId8BExBU?=
 =?us-ascii?Q?0116gTNcY27N4U4ubIwA/uyH8QnZ/jfZdtRQGYBjuGsmqlv88VythTCZG8WF?=
 =?us-ascii?Q?EUrwNqqIT2HWAIcV5PPZ9S4e7hd2Ieyb68mRdbtL/0lqs4rW+r1lWqg1wDqp?=
 =?us-ascii?Q?2xn2JDMeQXZqOloJKMirWa2A+TJ+T1RfQ5s06H41xETM9U2JKNumGHmox8cA?=
 =?us-ascii?Q?HsDg9UB8GX7J41S+KWT4ekcJYeUZDNrff+S5oZA2PYoiP3VqlRG24asyYqNL?=
 =?us-ascii?Q?+fIVQcKDPtVaCW8MVn9P/dTTYwaY9lR9rb6mdDK7Luv43FbgdwN2+/o9jtoq?=
 =?us-ascii?Q?ayoDGBSsjHyPdK66pan+YOXMRhRcVFfnH3F6nK3ArBu8Yr5U1zVguW3D2NZn?=
 =?us-ascii?Q?p5Xep8tMKZ4uaczLyjGO99NiGXLe/wYbswjT8AoBtOZqTOffJ9Jr5oiW6Y7p?=
 =?us-ascii?Q?YUwDZeFEEuG2Afz++H5XKG1Slp1/kp15hENUeKNCH2l8WVeD+aDq2cAMzSfd?=
 =?us-ascii?Q?PAeFRE1ztQr5Ar9t0HcuAJQcZxytT7KWsvbeN8Q/KgNBm7IqlFtzW3ybXIGt?=
 =?us-ascii?Q?LAAcThBGu2inaMWjoa4fezSrappT3nTZjj01bpyix/FFT9BXr8cJTmQfO3xH?=
 =?us-ascii?Q?sqOMMejN+8kZ2M7D+sgQhBNj+LOFAH2lcLezTkq3nM43v/FTzt8c1i3sd3Zz?=
 =?us-ascii?Q?VNDlR+1qpPq3Xwb/IgXbCIJtsp02Z7rsGj7E54q3E/llmU0EeKqOTuQptfoI?=
 =?us-ascii?Q?lEqYcWys8UgreW6bRBVRIvxrthYPjo155BuIIDbpDcmWeuDV+Xa/QFpVmcog?=
 =?us-ascii?Q?WVCksfxoTxNY3a3xzqVW9V2eza05+/GY2+91YV6EwdPKLh7j6C5BMDbsU1HK?=
 =?us-ascii?Q?JHia6ACHkiQK+3ViYtSj2MrqrR0OJ1EFM05GJjfohvPWAku1eFATtPs7rjyY?=
 =?us-ascii?Q?bo+9prhXRB+/aH1fq6ibMulnk74L27u91npn7v2jMXZF0Er5qr7XzVcMHk6m?=
 =?us-ascii?Q?WF2A0N1K8ziVJT/i5LWEPLeaAK72pNSd/IuL+si2BTrLuFpNaznQGwvi8Drv?=
 =?us-ascii?Q?nDTwgAearfjVBsh8cJ6k42I3yfVmPnSc5qR89C6QJErYWxaXfNsFxmNDUyzk?=
 =?us-ascii?Q?qokb4rbyv4ouC0bqCby3ejOQ/z6uJmIJJUEV9zcUroaAXzHyiPeo/6LWrQdM?=
 =?us-ascii?Q?A5uky+ucBR0Z5PQfqCxhXFrkle5CzxNGCnL2vcFMKuWPgSPYZjRU9nwYkNHw?=
 =?us-ascii?Q?N17j/FIVbvKLQTmfHz7FEVIEH5R+AC44cwxchpc583CkqK646ou6W9sR+YOi?=
 =?us-ascii?Q?+GySMwjqwJAan9mBEL7/g8nYOiMk60cYaRSh/eZe9u7IYOAz2ybvlgULf5jD?=
 =?us-ascii?Q?uHQkdY2EqSeco51YpLDO4HkpOPIv7nReRzVkmsNavkLF18DPi2sVNv7181lA?=
 =?us-ascii?Q?LNwit03NdBa9Xkgup7raL/7yY4+1niCWc8sxkYwkK0I9f4H9IOMnvjQtvgMc?=
 =?us-ascii?Q?iMidSFVb2ww0FrB997ddLPylQj0sXIbbVMW2HbJcwl1uY0JH+yc6lStTzWwO?=
 =?us-ascii?Q?D5aJmBdkDpyz8AOcoErMsBY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kJUGbGgoAGPWqzjkdOzR6LYWaFp8Nic1WtrXTbqR2L2T8eR/PqZS0lklm6qc?=
 =?us-ascii?Q?PzvT54frG9Eprfsn6bNxdbhfGynkvTg+2yydTK4PQCL3Yp/hSAojikhacagN?=
 =?us-ascii?Q?zu99l6341esQKKMWvs49ho1ZkFwkhNAjdvTxnleXuRBm59a3rJ8NqhDmCTiy?=
 =?us-ascii?Q?cSHqVicTjsA4zDy8hloMIOK02grDbqvKpssDCsoAQZ7VzvnDRggLVuG4EUp8?=
 =?us-ascii?Q?c6WFA+OPPM9Jnl9szAuWc3idxYQScCn8ET4z+I3Q9fA6VLMWTZc9F7Tm8lRC?=
 =?us-ascii?Q?1noVddxKfPGOXF+Ln6b6QvJJ9gjbgIWguBtLfZ4f9ojky28rJOIpqfzeuFQw?=
 =?us-ascii?Q?bgmTcWCDiQewYlKxabcKhDY7SWYm2re/Ww0OjF8uGj85apWKvioN7j7lHvlO?=
 =?us-ascii?Q?uxCD8CMYodihMUVfp9xGJz9cAkoRjlVOirQTPeNwhqg1IE40u7uWUB/lM509?=
 =?us-ascii?Q?PNHbDi6Y3p5jrapJX3eT7DVbBiXac7gh4cQKHi1ha1+WQ1Iqs0tx/kh/eWIi?=
 =?us-ascii?Q?I+/38ghXU3bWLD9eEpy6XPUK7PVa3anS8BqiwIaTfe5Qh4H1Wm3CfLQ7dCR9?=
 =?us-ascii?Q?J2qdx0tKmrAFxy0FQHRP/qpFoTMnwmvZZPlCvfCZaeju8XDuXZr768oDTrBB?=
 =?us-ascii?Q?jZ7nrzmT564HMecXzSHXptaIX7m4O7jwuaZTiyuQ8WE5gKFxNbEVKQT2y1cd?=
 =?us-ascii?Q?7FJ0qkmzDh/J57qpKKJXqatenCJG0Pz1fOl1CEDsG6HXDDhJ4TldBsvU4+DD?=
 =?us-ascii?Q?oe+hOFV+kbSALKrmbLl7LIfMj1BbeTLEaPiFWjkhii7wejJixpKFfHl2LzAC?=
 =?us-ascii?Q?kpMf42YvWMBJdPRPTguKpIu6OrPtFOfHVdz4KveRnGiDUoxfxtxMvLKUVXwq?=
 =?us-ascii?Q?SFqTjeMxLokN+R122cn44ONznXR/aVYicsFZN8T7ETSMP6rilAZ4VjUanNP2?=
 =?us-ascii?Q?h/O/zL/8VJRoyDwvcIyypugDoXThC7WwFM4qTNDVm/jAW4b2IpEdKaM9k/8+?=
 =?us-ascii?Q?rZ9HTvbYKzR+Ig9XpFO5BQeo+PiOUoeEDSQdi5J1T6dO0R8ufPEU6y+jiDIV?=
 =?us-ascii?Q?6AnE6o4IBOM8qoaKcRmulDQ3t2FzJPE+MnkUqZI+gFmTZ0xuXxycDUY7Q7gq?=
 =?us-ascii?Q?Xr1hRkT4o52BeVS2GdzcLMoEm6BesMIMuXsfmnaQmVq+Po1s4cRcVMgSF4GW?=
 =?us-ascii?Q?Z6z6IAXR4zrzJCz4uvDvyeCGS3kV8rRZ0ns0jNS33yFAsjv7wPqMHN+qTXg9?=
 =?us-ascii?Q?AAsUwBBFe+HlkM6wIjZlymmz++fmBbrsqHxPLVfX4PGj3nvz/ydgwF47WrWK?=
 =?us-ascii?Q?pwgwNB76mcwd9XnrHEsLBNEXSzmptmxG7skIxzGpFGYmyXFJGL/ozN0aGdLI?=
 =?us-ascii?Q?Rxzev/6QPmbaH287jcx/GpsNor0G0i6UV/B+llxcWgTfP677h2g3CS3teoYe?=
 =?us-ascii?Q?l2peqZtLhJFcJJucJiIUk+lU9IFkDmsDdi1DEIkD2xMgFkk9375plsqVbsCz?=
 =?us-ascii?Q?/bNhqHjcA9f/AZsCviZoKJhJY4v/g2ALfrd3cDTxUMA8E9Bibt4dY2V9nujL?=
 =?us-ascii?Q?F25Rei9lTrMMyX3AsCqMFnKOW97//YEXrgaaaxPKRkp9l+fSBodTv5Hkz6tX?=
 =?us-ascii?Q?BQmT5ggUyNtIuAhiI8KUjVsh8wS29IsQwgS/sH3mGvpwaEpnOn2xU03JuGgk?=
 =?us-ascii?Q?1e0GmgTgntjzP+oel6mkQ9tKcYpKGqrPq7bOliD75OIWMCtJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650c2210-50ad-4c7f-9b14-08de5a8b712d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 14:26:47.8677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHGOv27MCZZ4ZKYBZpFfD2ndSNx8fqYCGn8YYHuw+dEob/8T0GKzi2Rked6nD+F1xRLJ83p1VlvkbgydnqmqFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8465-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR12MB8120.namprd12.prod.outlook.com:mid,amd.com:email,amd.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D165770B9
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Frank

Please check my response inline.

Regards,
Devendra
> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, January 21, 2026 10:24 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> Support
>
[Removed some extra headers to reduce the size of the mail]
> > > > > On Fri, Jan 09, 2026 at 05:33:53PM +0530, Devendra K Verma wrote:
> > > > > > AMD MDB PCIe endpoint support. For AMD specific support added
> > > > > > the following
> > > > > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > > > > >   - AMD MDB specific driver data
> > > > > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > > > > >     base address.
> > > > > >
> > > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > > ---
> > > > > > Changes in v8:
> > > > > > Changed the contant names to includer product vendor.
> > > > > > Moved the vendor specific code to vendor specific functions.
> > > > > >
> > > > > > Changes in v7:
> > > > > > Introduced vendor specific functions to retrieve the vsec data.
> > > > > >
> > > > > > Changes in v6:
> > > > > > Included "sizes.h" header and used the appropriate definitions
> > > > > > instead of constants.
> > > > > >
> > > > > > Changes in v5:
> > > > > > Added the definitions for Xilinx specific VSEC header id,
> > > > > > revision, and register offsets.
> > > > > > Corrected the error type when no physical offset found for
> > > > > > device side memory.
> > > > > > Corrected the order of variables.
> > > > > >
> > > > > > Changes in v4:
> > > > > > Configured 8 read and 8 write channels for Xilinx vendor Added
> > > > > > checks to validate vendor ID for vendor specific vsec id.
> > > > > > Added Xilinx specific vendor id for vsec specific to Xilinx
> > > > > > Added the LL and data region offsets, size as input params to
> > > > > > function dw_edma_set_chan_region_offset().
> > > > > > Moved the LL and data region offsets assignment to function
> > > > > > for Xilinx specific case.
> > > > > > Corrected comments.
> > > > > >
> > > > > > Changes in v3:
> > > > > > Corrected a typo when assigning AMD (Xilinx) vsec id macro and
> > > > > > condition check.
> > > > > >
> > > > > > Changes in v2:
> > > > > > Reverted the devmem_phys_off type to u64.
> > > > > > Renamed the function appropriately to suit the functionality
> > > > > > for setting the LL & data region offsets.
> > > > > >
> > > > > > Changes in v1:
> > > > > > Removed the pci device id from pci_ids.h file.
> > > > > > Added the vendor id macro as per the suggested method.
> > > > > > Changed the type of the newly added devmem_phys_off variable.
> > > > > > Added to logic to assign offsets for LL and data region blocks
> > > > > > in case more number of channels are enabled than given in
> > > amd_mdb_data struct.
> > > > > > ---
> > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c | 192
> > > > > > ++++++++++++++++++++++++++++++++++---
> > > > > >  1 file changed, 178 insertions(+), 14 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > index 3371e0a7..2efd149 100644
> > > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > @@ -14,14 +14,35 @@
> > > > > >  #include <linux/pci-epf.h>
> > > > > >  #include <linux/msi.h>
> > > > > >  #include <linux/bitfield.h>
> > > > > > +#include <linux/sizes.h>
> > > > > >
> > > > > >  #include "dw-edma-core.h"
> > > > > >
> > > > > > -#define DW_PCIE_VSEC_DMA_ID                  0x6
> > > > > > -#define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> > > > > > -#define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> > > > > > -#define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9=
, 0)
> > > > > > -#define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(2=
5,
> 16)
> > > > > > +/* Synopsys */
> > > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID         0x6
> > > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR
> GENMASK(10,
> > > 8)
> > > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP
> GENMASK(2, 0)
> > > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH
> GENMASK(9,
> > > 0)
> > > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH
> GENMASK(25,
> > > 16)
> > > > >
> > > > > Sorry, jump into at v8.
> > > > > According to my understand 'DW' means 'Synopsys'.
> > > > >
> > > >
> > > > Yes, DW means Designware representing Synopsys here.
> > > > For the sake of clarity, a distinction was required to separate
> > > > the names of macros having the similar purpose for other IP,
> > > > Xilinx in this case. Otherwise, it is causing confusion which
> > > > macros to use for which vendor. This also helps in future if any
> > > > of the vendors try to retrieve a new or different VSEC IDs then
> > > > all they need is to define macros
> > > which clearly show the association with the vendor, thus eliminating
> > > the confusion.
> > >
> > > If want to reuse the driver, driver owner take reponsiblity to find
> > > the difference.
> > >
> > > If define a whole set of register, the reader is hard to find real di=
fference.
> > >
> >
> > It is not regarding the register set rather VSEC capability which can
> > differ in the purpose even for the similar IPs. As is the current case
> > where one VSEC ID serves the similar purpose for both the IPs while
> > the VSEC ID =3D 0x20 differs in meaning for Synopsys and Xilinx thus I
> > think it is OK to define new macros as long as they do not create confu=
sion.
>
> But need put rename existing macro to new patches. And I think use
> XILINX_PCIE_MDB_* should be enough without renaming. Everyone know
> DW is SYNOPSYS.
>

As the current addition of the code related to Xilinx piggybacking on the e=
xisting
DW code the prefix "DW" was added to the macros related to Xilinx as well.
The format available in the file has been followed.
When a necessity arises then perhaps the files can be separated and the nam=
e
suggestion would clearly indicate the distinction and difference required b=
etween
these two drivers.
Thanks to the reviewer(s), I had received multiple reviews regarding the na=
ming and finally
it was agreed upon the convention available in this version.
Please check the discussion in the following thread:
https://lore.kernel.org/all/SA1PR12MB81204C807C2F7C72730EC82295ADA@SA1PR12M=
B8120.namprd12.prod.outlook.com/

> >
> > > >
> > > > > > +
> > > > > > +/* AMD MDB (Xilinx) specific defines */
> > > > > > +#define PCI_DEVICE_ID_XILINX_B054            0xb054
> > > > > > +
> > > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > > > > > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR
> GENMASK(10,
> > > 8)
> > > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP
> GENMASK(2,
> > > 0)
> > > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH    GENMASK(9,
> 0)
> > > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH    GENMASK(25,
> > > 16)
> > > > >
> > > > > These defination is the same. Need redefine again
> > > > >
> > > >
> ...
> > > >
> > > > As explained above, the name change is required to avoid confusion.
> > > > The trigger to have the separate names for each IP is the
> > > > inclusion of Xilinx IP that is why no separate patch is created.
> > >
> > > Separate patch renmae macro only. Reviewer can simple bypass this
> > > typo trivial patch.
> > >
> > > Then add new one.
> > >
> > > Actually, Needn't rename at all.  You can directly use XLINNK_PCIE_*
> > >
> > > Frank
> >
> > Please check the discussion on previous versions of the same patch seri=
es.
>
> It'd better you put link here to support your purposal.
>
> > We have this patch as the outcome of those discussions.
> > Other reviewing members felt it that keeping the name similar for the
> > VSEC ID having similar purpose for two different IPs was causing the
> > confusion that is why it was agreed upon the separate out the naming
> > as per the vendor-name of VSEC ID. Regarding the separate patch, the
> > reason is introduction of the new IP which mostly supports the similar
> > functionality except in case of VSEC IDs that's why the name
> > separation became part of these patches. It sets the context for changi=
ng
> the name of the existing macros.
>
> If put trivial big part to new patch to reduce, it will reduce review eff=
orts.
>
> Frank
>

As requested, a link related to discussion in this regard is available on t=
he above
comments, please take a look.

> >
> > > >
> > > > > >
> > > > > >       pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > > > >       off =3D val;
> > > > > > @@ -157,6 +237,67 @@ static void
> > > > > dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > > > > >       pdata->rg.off =3D off;
> > > > > >  }
> > > > > >
> > > > > > +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev
> *pdev,
> > > > > > +                                          struct
> > > > > > +dw_edma_pcie_data
> > > > > > +*pdata) {
> > > > > > +     u32 val, map;
> > > > > > +     u16 vsec;
> > > > > > +     u64 off;
> > > > > > +
> > > > > > +     pdata->devmem_phys_off =3D
> > > DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > > > > > +
> > > > > > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XIL=
INX,
> > > > > > +                                     DW_PCIE_XILINX_MDB_VSEC_D=
MA_ID);
> > > > > > +     if (!vsec)
> > > > > > +             return;
> > > > > > +
> > > > > > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val)=
;
> > > > > > +     if (PCI_VNDR_HEADER_REV(val) !=3D 0x00 ||
> > > > > > +         PCI_VNDR_HEADER_LEN(val) !=3D 0x18)
> > > > > > +             return;
> > > > > > +
> > > > > > +     pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific
> > > > > > + Extended Capability
> > > > > DMA\n");
> > > > > > +     pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > > > > +     map =3D FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > > > > > +     if (map !=3D EDMA_MF_EDMA_LEGACY &&
> > > > > > +         map !=3D EDMA_MF_EDMA_UNROLL &&
> > > > > > +         map !=3D EDMA_MF_HDMA_COMPAT &&
> > > > > > +         map !=3D EDMA_MF_HDMA_NATIVE)
> > > > > > +             return;
> > > > > > +
> > > > > > +     pdata->mf =3D map;
> > > > > > +     pdata->rg.bar =3D
> > > FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR,
> > > > > val);
> > > > > > +
> > > > > > +     pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > > > +     pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
> > > > > > +
> > > > > > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH,
> > > > > val));
> > > > > > +     pdata->rd_ch_cnt =3D min_t(u16, pdata->rd_ch_cnt,
> > > > > > +
> > > > > > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > > > > > +
> > > > > > +     pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > > > > +     off =3D val;
> > > > > > +     pci_read_config_dword(pdev, vsec + 0x10, &val);
> > > > > > +     off <<=3D 32;
> > > > > > +     off |=3D val;
> > > > > > +     pdata->rg.off =3D off;
> > > > > > +
> > > > > > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XIL=
INX,
> > > > > > +                                     DW_PCIE_XILINX_MDB_VSEC_I=
D);
> > > > > > +     if (!vsec)
> > > > > > +             return;
> > > > > > +
> > > > > > +     pci_read_config_dword(pdev,
> > > > > > +                           vsec +
> > > DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > > > > +                           &val);
> > > > > > +     off =3D val;
> > > > > > +     pci_read_config_dword(pdev,
> > > > > > +                           vsec +
> > > DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > > > > +                           &val);
> > > > > > +     off <<=3D 32;
> > > > > > +     off |=3D val;
> > > > > > +     pdata->devmem_phys_off =3D off; }
> > > > > > +
> > > > > >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > > >                             const struct pci_device_id *pid)
> > > > > > { @@
> > > > > > -184,7 +325,28 @@ static int dw_edma_pcie_probe(struct pci_dev
> > > *pdev,
> > > > > >        * Tries to find if exists a PCIe Vendor-Specific Extende=
d Capability
> > > > > >        * for the DMA, if one exists, then reconfigures it.
> > > > > >        */
> > > > > > -     dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> > > > > > +     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> > > > > > +     dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> > > > > > +
> > > > > > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> > > > >
> > > > > dw_edma_pcie_get_xilinx_dma_data() should be here.
> > > > >
> > > > > Frank
> > > >
> > > > Yes, this is good suggestion. Thanks!
> > > >
> > > > > > +             /*
> > > > > > +              * There is no valid address found for the LL mem=
ory
> > > > > > +              * space on the device side.
> > > > > > +              */
> > > > > > +             if (vsec_data->devmem_phys_off =3D=3D
> > > > > DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > > > > +                     return -ENOMEM;
> > > > > > +
> > > > > > +             /*
> > > > > > +              * Configure the channel LL and data blocks if nu=
mber of
> > > > > > +              * channels enabled in VSEC capability are more t=
han the
> > > > > > +              * channels configured in xilinx_mdb_data.
> > > > > > +              */
> > > > > > +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, =
0,
> > > > > > +                                            DW_PCIE_XILINX_MDB=
_LL_OFF_GAP,
> > > > > > +                                            DW_PCIE_XILINX_MDB=
_LL_SIZE,
> > > > > > +                                            DW_PCIE_XILINX_MDB=
_DT_OFF_GAP,
> > > > > > +                                            DW_PCIE_XILINX_MDB=
_DT_SIZE);
> > > > > > +     }
> > > > > >
> > > > > >       /* Mapping PCI BAR regions */
> > > > > >       mask =3D BIT(vsec_data->rg.bar); @@ -367,6 +529,8 @@
> > > > > > static void dw_edma_pcie_remove(struct pci_dev
> > > > > > *pdev)
> > > > > >
> > > > > >  static const struct pci_device_id dw_edma_pcie_id_table[] =3D =
{
> > > > > >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > > > > > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > > > > > +       (kernel_ulong_t)&xilinx_mdb_data },
> > > > > >       { }
> > > > > >  };
> > > > > >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > > > > > --
> > > > > > 1.8.3.1
> > > > > >

