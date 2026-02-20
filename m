Return-Path: <dmaengine+bounces-8985-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIl9JPhJmGk6FQMAu9opvQ
	(envelope-from <dmaengine+bounces-8985-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 12:48:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4F31675D0
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 12:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BA47302D5E9
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E8F3191CE;
	Fri, 20 Feb 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QfU071/s"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A282045AD;
	Fri, 20 Feb 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771588085; cv=fail; b=W9HmjEsqxYQnUyFwa3GzHWramubwKF2PsCt9dO/NrrBw7DpmOTqJ2ntDTpslvg7cZIvSiKPgnV8OFg0LegCmVODUsdoj53bQDcWKesUjzssVYAxD+HU58C7fTRyEdaBgZ2yWl/6V+VQ25X2WeyIvngR5bKPgSJnH7F+eQe6Zd5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771588085; c=relaxed/simple;
	bh=qUKmZIZQuzaH8kY6c/y67ROf9h/i2flIFBec15JqnB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V86vQcU+MAIUb1uzonw1q6wy2AkI1MZ2zSbc/23LbdKOVs7A0DN8aUEx7S2/VA8AI0llB99A7Ru0iwU/+LmlcP7EhjQaiTyWSjsvxiCpvUYFpCWL46qH+8/Vr6IKClCoVq+SAHKAKbQX+g8zjPWiVjGBKUGzpI7u+upZEKHLgtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QfU071/s; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMsgS4AGx5ep37+kLGJsALyFUfFcQmU/y4jEAM/xq2HbYsEo5WX/zO83XOYUIr3+DPPadkx6QSKdH8wXmcXflfwmHK/W+BxmYN4knubml1qV+3AC/HmfMDmmkKs0CmLNLEUoQ/6etCtUZov87xm8tbC3Bf94i7dNxsK8FbStDdLc4fA0OKqZ5SZpe4dhb1t/VDqFRPTVrKlpauNJQZuAYr3K9RbVOuxhGEqOzWHWWL3bJAr+4NQSvIU8gGBw7L+Zj14QoCmzZ883wB25duTb/QOV0GGnlS3djSxYxacrisZ+mtQ5MyNiycKMlu6rOnaSl/h42ZGnVRxQSxmKlS2cyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhrRKVXWV824VP6uvTrbCe1CBTssTJCrD2Zv7WuRYtI=;
 b=M5UmysakK3mc2KMGBX8lQ7rfpPaYYLB5g+QXMNohbMcDwMFe7yqpTY0Iq0whqWPA59SuNmIs8vhV8bpxSC/4Ve3HGlSsLde+x7rouBcbzWZ06PJRMc6sIFcmXz7bmdaxOHKCdt+kJp+6ZVLNvLDF0I7gOrJO0mPdzsjxKXBMSmX15/gEzNlUkEE0SbR3y4bdrdat46Sc+bHX9mt6R9nCzaiQ8O7GgJukh8bD0UxNrEo4wyDLvrYfayPmo1WnzVKhtcijxdn0pbvz2Aej9WgwSPyQLSSYx/fhVK1zEsRlCD3uhV9OvANHRoURftABDkXmrqRbn3CfZkp1e+Mk4O6ncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhrRKVXWV824VP6uvTrbCe1CBTssTJCrD2Zv7WuRYtI=;
 b=QfU071/sXi9hsQVV759c4jaSOhwjIQ+kqAmqG4dSJgu7lFt9foYGZ+XVguGizLMc4V7vuvvjBR2jK1Ozj6EesJTlNSx+JbLIKVjDlsZC/KEqnjlSfNgrr6JSEDFVw1QfFVaoQ/Vrc+Vk/HQ+UB3LEQKqBsCn5SKrYLQehNntbOw=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 11:47:59 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 11:47:59 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index:
 AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXCAALfggIABEsjwgABxvwCAAOnmsIAAvjoAgAEKjvA=
Date: Fri, 20 Feb 2026 11:47:59 +0000
Message-ID:
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
In-Reply-To: <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-20T09:01:46.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|SJ0PR12MB6879:EE_
x-ms-office365-filtering-correlation-id: d8c9b4e2-bac9-4c6e-cb0c-08de7075e545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3Uf2B4AXoZpM5t3R1yVeN+hsM/u1X2NVVI7Lohany08+6FsAeTOI/D+Y9mrP?=
 =?us-ascii?Q?U1hpNB2Los5CqCw3ues87EHKqdOaE64wnqdhKeRdJsjStD3+SSz62m9pqZ/t?=
 =?us-ascii?Q?F2ka5vMt/j0XcgJISnJR+H002MpA8r+Ec5SdoWhDtCHS7fmuVZZI3aobuG4B?=
 =?us-ascii?Q?qYwcCuo2kuEewjrWJ9MRKyl0VN4mNRacshV+feTOf6sy/q2aIZb/9w34X7Sa?=
 =?us-ascii?Q?qXLl+QLUsR8IpbKBnmvDafmAplDOMOBlLbuOGwy9OiQonx7LoZ/7MKw56XLa?=
 =?us-ascii?Q?AlA+oGH3FXTOHIQ0MhLilNDs5zKw9K1+6zSUmVgtPO/9v4IypRY661T/mMsY?=
 =?us-ascii?Q?Jmnu9fJQejRpnl5fV6XJmCO33kbTRDuRHh4On+FFWJC8fCJhhtjbYSdpzfCi?=
 =?us-ascii?Q?xJEXg2fHk/5rBOZ6MVvwPnc5sXyUcsDBNIHWgCjyj+P+lBuGlSkDwifbP88f?=
 =?us-ascii?Q?smwOUwp2KF8Cuci3QYkNydS3+Mv/YyVernQa5JcSmVzNo/Pavg3+strLuT5/?=
 =?us-ascii?Q?oS98LosgMfHDi0rtYud1LeaSaHSJzUSu2pCVSeSjbT/nIuhZs2dmADO7W8kf?=
 =?us-ascii?Q?gfDH0sifTP7B2MbVq6/92Uvcq6OEjRxbK8d9Mk0LnuKc8LO67dQbfDvKdX7h?=
 =?us-ascii?Q?YN+7iaRY72o3NzyOnnm4Hj8IHMlVLW3L/Mlz7Fj1d2BQllBXlUJG1Ja+QgyF?=
 =?us-ascii?Q?uLj5NaTz7QuX5Vnkgs9jxao35wbernTGKxEn6CIBaBBZ5AZ7M24kgYcFMpB3?=
 =?us-ascii?Q?FM0KmEVMP7uwHK8W9akDzY16dqmbvAa/u86EnFzkDwoSy4vSc5/XLNKfkeEW?=
 =?us-ascii?Q?jufklHGGR9cCCryV+NYwRPnMH2eygvMM3zsDiTmeBEpHzdVzx5CZJNEv+2zc?=
 =?us-ascii?Q?nv4HrJi3LLMJZYdsdNgKgoAdG0GO0Mt9WNFr7rjjygdVb8i3+EH84+ikA9PO?=
 =?us-ascii?Q?M0nrcRItYx077bdyrwO4hbfSGYFRFDUhJCPTPp/U3it81dEPRqaY+re/1B/q?=
 =?us-ascii?Q?NQ3XWTtyqrB/3ywM80wIrAA3lgqXTaGVZl3Vrm2dMA+C+F6JzFrZIQuBqBoG?=
 =?us-ascii?Q?KW4wlhnVYBE/r3Lbp+p6vE/y8FWBs6DYi9RD7j4oZNpKL3tG7QYOgZqdBx/v?=
 =?us-ascii?Q?ff3ibZ7LcKThDzokp6ADBKDY8SawudUzE1eLdqTt67PTKvSNF7SwqvsIr+wT?=
 =?us-ascii?Q?KuKkPF/o9MnEmkCEO9yaKSJNmpds08nuQ5dOKDXKyirY0ih24juJqisMFN2g?=
 =?us-ascii?Q?7BP9IcKG/hrCZio2ex4t4i9gVWFUtfhF76d5v67Dc+2s/B74fhSq6JmaysmR?=
 =?us-ascii?Q?HkSu1o0IHczb/AeYjBBuqCE8WGzIqNS3fb0QdxWE6BWWfGXtEfgEPLlYoaXg?=
 =?us-ascii?Q?2ycktEpHTsk/zL+tBpODMndrTx4GgvnT6TKPREp4XJdRcomtypnRTp9jDMJg?=
 =?us-ascii?Q?l0P4AAwvXVAdgpJSuyedm6aRR3G+okPLIzPtduqWgWR5cvF70uGDVoCBPDzu?=
 =?us-ascii?Q?gRGq8NKcYaAzPhmVaCBrKbXhAxZ+kPc0v9pVkTjBLsia0oeoOCfp5vHTUdDM?=
 =?us-ascii?Q?4WsUBZioLiviY7gyN6dc71dHW1dBNRucZrftr1pEq+VtTKHYAUkCVvzs8aMi?=
 =?us-ascii?Q?3xEDhBJRRVIDMI8i2C1wtO8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aet7BOmsURYeBa1OO+tu068xYEc820ZDw3d4n0l03tBleJdHdGN9zoe1+wKk?=
 =?us-ascii?Q?ZAwEQjadBE9Q56fuvjtxTGH7fOLI53RCk5U1jqoGBkPFSNeqTaMESwXAP9Vy?=
 =?us-ascii?Q?eEsVYSDgHAFBX3VNkOuZEDFUTEUc+WOjLrcHV9UwlCrHkt00+a1olCDDqxT2?=
 =?us-ascii?Q?m3cJioDvWjPQzNxgR8hY5CIQZc9Y5CUueCX4VCoYNNeKiB2jakiU9WuFPR5O?=
 =?us-ascii?Q?ZVjl5N+CZ4mblhvNLp2YS5iBcJxqdm4X5rSCDHtsQFsgv9oz5nCb9/lfgZGT?=
 =?us-ascii?Q?cUkapULkGzb54/eTHxX0B47+SQkZ1me77ZmTCl+R03RrvO6sn2ZVrZaUqbzI?=
 =?us-ascii?Q?ozML0MVJM/ybIDowBxT7aPSeCkioowE+iVWEdbbpTzsr61qlTyXLEivT+5It?=
 =?us-ascii?Q?NCibgKFKL92PtBVqp8gqz7vi+6JJHEq034O5F2/nWbYj+kBE4WizxJ/CWTDs?=
 =?us-ascii?Q?2BfZxuE2fV5vl9NkgpbWDGQMTpliwWCRKPN24R+3m2Jtgh7aUT+VAvp23qLC?=
 =?us-ascii?Q?xWTwzraQ5XWRIBjGCgGObMxkZMHthtiFNs9ycn0uwxGCP9ylP0Qo3T21w6Yh?=
 =?us-ascii?Q?G/PP/5JxiFr8eu9JQ0+h4TF1JQy4x2wfzCV2Yrc66KdxO+ESgroibIrkaZag?=
 =?us-ascii?Q?38+K8CRI5worGeDXJL+9Zk0WBbB4We5+fbVQMqoFw8Er0fJE10aGGRZPN1dv?=
 =?us-ascii?Q?Zu3QzLRMEtR9SYu/hLeCEDW69GCmcoxy1MXFp8HKgWFjLR2JvoFfNUSooAq5?=
 =?us-ascii?Q?UGjOw6TeOHkLoF+ZPum8AxTzOjmPpNTbP1Id1iJWbA7mkbtYO7bOojMKLbi6?=
 =?us-ascii?Q?wo0wxXsoGKzj8YiGZq4OuIoCr+GlByfuxRS1ggJFNWDfBPcw9mgEakzlvfJF?=
 =?us-ascii?Q?ZesLNbXJGbs6b3NfxkoxmJkYtOHSmosHNF1R4eQc34YnQTjD1BLaaczOVzhK?=
 =?us-ascii?Q?XU6BnEOFMy2+V89sCGzLKhuBSv4xpHSd5PthtHuxOhiiSAGZD+JPjNprUdCs?=
 =?us-ascii?Q?4iVBWqw+kkgy2r51YyLv03mau2TTXfikSiF8G4gCR61jRu6a2UbCpSKcq2Ib?=
 =?us-ascii?Q?KFnr69aq4Sm1n1ou2K5l40eU9pbB49s40m6i0hgEC6Ex7hGxcbBsdvl6n74p?=
 =?us-ascii?Q?seVay8TeXdFWRKGu0u3+3O5Neg+yAti8wpClUYDevVl4pIyfbHm6VWltGskv?=
 =?us-ascii?Q?e317wU2Hho1nKwWtVJVxVJybySwLTH1VVDRvN0cOrnSJTbF7W3J953ZZSRu7?=
 =?us-ascii?Q?8AVVCUCcRbjms9yIy+nSs75iK2raaEybnF9FfInkH56Qptg7G9YeJlPGQJbC?=
 =?us-ascii?Q?qdbhSl7ADBQUVNIq10B//IGgE6LFHk53LuC3lpHVB4amCypca7IeykxenNLk?=
 =?us-ascii?Q?YVAsynvJSsX24Aw7qVufmR8qk+8vPo0dO4pia52HldSokbLh+FP0Prv6chhC?=
 =?us-ascii?Q?EcjgkJc7pvphLkdOS3nEzfZxQNh0NlUV2cfBgFajtCdZRt9OzV6sC2CId4SM?=
 =?us-ascii?Q?kqSHkfBp1QxQNe7HPqXUPqKByk2KHXbl+B31uYpyLuuB/uEC9x9P5VYNzJqU?=
 =?us-ascii?Q?Lh81fwtGCtIxlk5+O9R6BkCqiLW+TRQZ8HA0z4t78e0EK5Gz6VrPKeQL28cU?=
 =?us-ascii?Q?ihQCthGsgplB90nYr8oWNzr5np8TI8/eWas+s8Rpvu8ZWQkH/kpd4vMmVrn9?=
 =?us-ascii?Q?ULLTUv03dPdcteqyAFopfxyVAvAbip+AvKMuI9MoDFO6oXp0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c9b4e2-bac9-4c6e-cb0c-08de7075e545
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 11:47:59.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pao0KOCIHIDeM3rsM01nboRiB1RFZWBYQMcIqvioiDYm5kjoT2e+xYqGD+wH5Wdj7cC/qRz8HpYo928ybxJrzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8985-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,amd.com:email,amd.com:dkim,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: DE4F31675D0
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Frank
Please check my response inline

Regards,
Devendra
> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Thursday, February 19, 2026 10:38 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode

---[ Snipped some text to reduce mail size ]---

> > > > > > > On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma
> wrote:
> > > > > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL
> mode.
> > > > > > > > The current code does not have the mechanisms to enable
> > > > > > > > the DMA transactions using the non-LL mode. The following
> > > > > > > > two cases are added with this patch:
> > > > > > > > - For the AMD (Xilinx) only, when a valid physical base add=
ress of
> > > > > > > >   the device side DDR is not configured, then the IP can st=
ill be
> > > > > > > >   used in non-LL mode. For all the channels DMA transaction=
s will
> > > > > > > >   be using the non-LL mode only. This, the default non-LL m=
ode,
> > > > > > > >   is not applicable for Synopsys IP with the current code a=
ddition.
> > > > > > > >
> > > > > > > > - If the default mode is LL-mode, for both AMD (Xilinx) and
> Synosys,
> > > > > > > >   and if user wants to use non-LL mode then user can do so =
via
> > > > > > > >   configuring the peripheral_config param of dma_slave_conf=
ig.
> > > > > > > >
> > > > > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > > > > ---
> > > > > > > > Changes in v10
> > > > > > > >   Added the peripheral_config check only for HDMA IP in
> > > > > > > >   dw_edma_device_config().
> > > > > > > >   Replaced the loop with single entry retrieval for non-LL
> > > > > > > >   mode.
> > > > > > > >   Addressed review comments and handled the burst allocatio=
n
> > > > > > > >   by defining 'bursts_max' as per suggestions.
> > > > > > > >
> > > > > > > > Changes in v9
> > > > > > > >   Fixed compilation errors related to macro name mismatch.
> > > > > > > >
> > > > > > > > Changes in v8
> > > > > > > >   Cosmetic change related to comment and code.
> > > > > > > >
> > > > > > > > Changes in v7
> > > > > > > >   No change
> > > > > > > >
> > > > > > > > Changes in v6
> > > > > > > >   Gave definition to bits used for channel configuration.
> > > > > > > >   Removed the comment related to doorbell.
> > > > > > > >
> > > > > > > > Changes in v5
> > > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > > >   In the dw_edma_device_config() WARN_ON replaced with
> > > dev_err().
> > > > > > > >   Comments follow the 80-column guideline.
> > > > > > > >
> > > > > > > > Changes in v4
> > > > > > > >   No change
> > > > > > > >
> > > > > > > > Changes in v3
> > > > > > > >   No change
> > > > > > > >
> > > > > > > > Changes in v2
> > > > > > > >   Reverted the function return type to u64 for
> > > > > > > >   dw_edma_get_phys_addr().
> > > > > > > >
> > > > > > > > Changes in v1
> > > > > > > >   Changed the function return type for
> dw_edma_get_phys_addr().
> > > > > > > >   Corrected the typo raised in review.
> > > > > > > > ---
> > > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
> > > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++---=
-
> --
> > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > > > > > > > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-
> hdma-
> > > v0-
> > > > > > > regs.h |  1 +
> > > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > > >  6 files changed, 132 insertions(+), 15 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > index b43255f914f3..ef3d79a9f88d 100644
> > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > @@ -223,6 +223,31 @@ static int
> > > > > > > > dw_edma_device_config(struct
> > > > > > > dma_chan *dchan,
> > > > > > > >                                struct dma_slave_config *con=
fig)  {
> > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > dchan2dw_edma_chan(dchan);
> > > > > > > > +     int non_ll =3D 0;
> > > > > > > > +
> > > > > > > > +     chan->non_ll =3D false;
> > > > > > > > +     if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) {
> > > > > > >
> > > > > > > Need handle EMDA case. if mf is EDMA, need return error when
> > > > > > > config->peripheral_config is not NULL. Or remove above check
> > > > > > > config->to make
> > > > > > > code work for both EDMA or HDMA.
> > > > > > >
> > > > > >
> > > > > > For the case of EDMA, the behavior is unchanged.
> > > > > > Even if the config->peripheral_config param is set then it
> > > > > > would be simply
> > > > > ignored.
> > > > > > This is retention of the previous behavior. This is done
> > > > > > because device_slave_config has other params which affect the
> > > > > > behavior of the DMA transactions, we do not check all those
> > > > > > params and return any error. The error is returned only in the
> > > > > > cases where particular parameter from dma_slave_config is used
> > > > > > and if the parameter is not as expected or in the expected
> > > > > > form. The parameter used from dma_slave_config for the
> > > > > > particular IP type need to be known first then it
> > > > > can be checked for its correctness. This is behavior for the
> > > > > peripheral_config which is used for HDMA and thus error checked.
> > > > >
> > > > > It actaully hidden error. Your patch provide an option, which
> > > > > need't ll memory to do DMA transfer. DMA consumer actaully don't
> > > > > know which backend used, which is private information by DMA
> engine providor.
> > > > >
> > > > > dw-edma-pcie.c is only one of all edma users, which know DMA
> > > > > engine's information because it creates this interface.
> > > > >
> > > > > PCIE-EP framework also create dmaegine, PCIE-EP function driver
> > > > > use DMA standard interface to get dma-chan.
> > > > >
> > > > > if (config->peripheral_config) { /* only your specific dma
> > > > > consumer set it now */
> > > > >         /* optional config information */
> > > > >         if (chan->dw->chip->mf !=3D EDMA_MF_HDMA_NATIVE) {
> > > > >                 dev_err("edma have not implmentent no-lll mode\n"=
)
> > > > >                 return -EINVAL
> > > > >         }
> > > > >
> > > > >         ...
> > > > > }
> > > > >
> > > > > Add EDMA support no-ll mode is quite easily in future.
> > > > >
> > > >
> > > > This looks reasonable provided that HDMA got the support for this
> param.
> > > > An error check can be added in the next revision.
> > > > The addition may be slightly different as following:
> > > > If (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) { ...
> > > > } else if (config->peripheral_config) {
> > > >  /* error handling */
> > > > }
> > > >
> > > > Using the above, if support needs to be added to EDMA then a check
> > > > for
> > > correct 'mf'
> > > > in the if() shall be sufficient.
> > > >
> > > > > >
> > > > > > > > +             if (config->peripheral_config &&
> > > > > > > > +                 config->peripheral_size !=3D sizeof(int))=
 {
> > > > > > > > +                     dev_err(dchan->device->dev,
> > > > > > > > +                             "config param peripheral size=
 mismatch\n");
> > > > > > > > +                     return -EINVAL;
> > > > > > > > +             }
> > > > > > > > +
> > > > > > > > +             /*
> > > > > > > > +              * When there is no valid LLP base address
> > > > > > > > + available then
> > > the
> > > > > > > > +              * default DMA ops will use the non-LL mode.
> > > > > > > > +              *
> > > > > > > > +              * Cases where LL mode is enabled and client
> > > > > > > > + wants to use
> > > the
> > > > > > > > +              * non-LL mode then also client can do so via=
 providing
> the
> > > > > > > > +              * peripheral_config param.
> > > > > > > > +              */
> > > > > > > > +             if (config->peripheral_config)
> > > > > > > > +                     non_ll =3D *(int
> > > > > > > > + *)config->peripheral_config;
> > > > > > > > +
> > > > > > > > +             if (chan->dw->chip->non_ll ||
> > > > > > > > + (!chan->dw->chip->non_ll && non_ll))
> > > > > > >
> > > > > > > if chan->dw->chip->non_ll is true, It should return error if
> > > > > > > you set non_ll false because no LLP base available.
> > > > > > >
> > > > > >
> > > > > > In case the 'chan->dw->chip->non_ll' is true, then the default
> > > > > >mode  becomes non-LL for HDMA ONLY. There is no option to the
> > > > > >user to  configure the LL mode by giving 'non_ll =3D false' as
> > > > > >part of the
> > > > > >config- peripheral_config.
> > > > >
> > > > > This is API's callback, you can't assume caller do all correct th=
ings.
> > > > >
> > > > > > The configuration of default non-LL mode depends on how the IP
> > > > > > is programmed by the user. The user is aware of the IP configur=
ation.
> > > > >
> > > > > It is not true. DMA consumer don't know such detail information,
> > > > > which only know which dma engineer providor.
> > > > >
> > > >
> > > > For the DMA consumer the only option is LL mode as default mode.
> > > > In order to use the non-LL mode it need to provide the parameter
> > > > in the form
> > > of peripheral_config.
> > > > Given the above statement, the consumer even if gives the 'non_ll
> > > > =3D false', it is not going to change any behavior.
> > > > Even if the user is not giving the option the assumption is that
> > > > controller is in LL mode, unless the DMA engine provider provides
> > > > the information regarding non-LL mode as default mode to the DMA
> > > > consumer
> > > explicitly.
> > > > In the case where chan->dw->chip->non_ll =3D true, following case
> > > > may
> > > happen:
> > > > - DMA consumer provides no peripheral_config param or simply
> > > >config- peripheral_config =3D NULL,
> > > >    in this case non_ll =3D false which is the current flow.
> > > > - DMA consumer provides a valid peripheral_config (!=3D NULL) param
> > > >but the
> > > value is '0', in this case
> > > >   It is explicit but it would have the same effect as above case.
> > > >
> > > > DMA consumer is supposed to provide the only option non_ll as it
> > > > was not available and LL mode is set as default for the DMA operati=
ons.
> > > > When 'chan->dw->chip->non_ll =3D true' then this was added to make
> > > > the chip usable when the LLP base addresses are not configured.
> > > > Without this, user cannot use any of the modes be it LL or non-LL
> > > > if the LLP base
> > > address is not configured.
> > >
> > > little bit confuse, Maybe the same as you. I expected behavor
> > >
> > > config->peripheral_config =3D NULL        choose hardware default one
> > >                                         -           LL mode if hardwa=
re support
> > >                                         -      none-LL mode if not ll=
 list region
> > >
> > > config->peripheral_config !=3D NULL
> > > EDMA: return false
> > > HDMA:
> > >                 0                       force to none_ll mode. (alway=
s success)
> > >                 1                       force back to ll mode  (retur=
n false if no ll list region
> in
> > > chip)
> > >
> > > DMA consumer decide if fall back to none_ll to continue.
> > >
> >
> > Thank you for the elaboration!
> > I have few questions, why shall a DMA consumer decide to enable LL
> > mode when the default mode supported is LL mode only?
>
> LL mode only is software driver implement. Hardware support both LL mode
> and no-LL mode. Previous driver implement only support LL mode. You try t=
o
> add non-LL mode. Choose straightforward forward method.
>
> One indicate hardware capacity,  one actually used. Like PCI INTX and MSI=
.
> If support MSI, most case use MSI. But still support switch to use INTX.
>
> My key point avoid hidden beavior. Every branch is clean and straightforw=
ard.
>
> >
> > If DMA consumer is trying to enable the LL mode, then one must be
> > knowing the configuration of the controller that controller is working
> > in non-LL mode, as LLP base address is not configured,then why to try a=
nd
> enable the LL mode?
>
> The DMA consumer don't know these informaiton.
>
> >
> > The user need to know, at least, one detail from the above two cases.
> >
> > The use for non-LL mode is useful in the following scenario:
> > - When user want to utilize the LL regions also for DMA data transfers.
> > - For single and big chunks non-LL mode is useful in both use-cases whe=
n
> non-LL mode is default or
> >   user enables it via peripheral_config params.
> > - This addition, inadvertently, makes the DMA controller usable, for AM=
D
> (Xilinx) only, when the LLP
> >   base addresses are not configured; it can be used in non-LL mode.
>
> LL regions may not visiable,  User can use non-ll to config LL-region and=
 switch
> back to use LL-region to continue transfer. User may use non-ll as indire=
ctly
> reg access.
>
> > For Synopsys, DMA controller
> >   cannot be used in any mode if LLP base address is not configured.
>
> Does spec said it? It doesn't make sense. it should be controlled by LLE =
of
> DMA_CH_CONTROL1_OFF_RDCH_0.
>
> >
> > Based on the above points, if user is trying to enable LL mode when
> > default mode is LL mode, it looks Intentionally making the choice when =
user
> is aware of the mode DMA controller operating in.
> > Please let me know if this clarifies the doubt.
>
> No API to get mode, only use set and test to know it.
>
> Actually Needn't consider so complex. like functions API(x)
>
> We just consider input x,
>
>         validate x's input ragion,
>
>         if x is out of region, just return error.
>

Thanks! Will update in the next version.

> >
> > > >
> > > > > > The check for non-LL option
> > > > > > provided by the user is useful when LL-mode is default. That
> > > > > > is why the value of non_ll =3D=3D false is not even evaluated.
> > > > > >
> > > > > > > > +                     chan->non_ll =3D true;
> > > > > > > > +     }
> > > > > > > >
> > > > > ...
> > > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > > b/include/linux/dma/edma.h index
> > > > > > > > 3080747689f6..78ce31b049ae
> > > > > > > > 100644
> > > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > > >       enum dw_edma_map_format mf;
> > > > > > > >
> > > > > > > >       struct dw_edma          *dw;
> > > > > > > > +     bool                    non_ll;
> > > > > > >
> > > > > > > Can you check ll_region directly? it should be equal to
> > > > > > > (ll_region->sz =3D=3D 0)
> > > > > ?
> > > > >
> > > > > Do you miss this questin?
> > > > >
> > > > > Frank
> > > > >
> > > >
> > > > Yes, looks like I missed this question. Could you explain a little
> > > > bit more? I
> > > am unable to understand the context.
> > >
> > > you set chip->non_ll =3D non_ll in dw_edma_pcie_probe()
> > >
> > > and only set ll_region->sz =3D ll_block->sz when !chip->non_ll.
> > >
> > > Thats means ll_region->sz is 0 when chip->non_ll is true.
> > >
> > > So non_ll have not bring new infomation into dw_edma_chip.
> > >
> > > check !ll_region->sz, which should be equal to this non_ll.
> > >
> > > dw_edma_chip is the exchange information between controller and dma
> > > core driver. Needn't cache it here because you already save a copy in=
 dma-
> chan.
> > >
> > > Frank
> >
> > I understand the concern here but it does not look good to piggyback
> > the non_ll related information on the existing variable.
> > The use of bool readily points out the information related to what
> > mode is being intended but using the ll_region->sz is an inference the =
user
> has to make.
> >
> > Having ll_region->sz =3D=3D 0 does not really tell it is non_ll mode or
> > not, it can also mean that the size of LL region is zero while in LL mo=
de
> which could be an error.
> > This does not translate to support for non-LL mode. This brings the
> ambiguity.
> > The introduction of the non_ll provides clarity and easy comparison
> > with the similar choice (non_ll) provided by the DMA consumer in the
> dmaengine_slave_config().
> > I request we shall retain the clarity here.
>
> You can use helper(dw_chip_is_support_ll()) macro to check chip's
> capatiblity.
>

I do not understand what you mean with the above statement.
But if it about writing a new function to check the LL mode support
then I think the current variable is good enough which provides good readab=
ility
and do not create any ambiguity compared to the ll region size comparison.

> Frank
> >
> > > >
> > > > > > >
> > > > > > > Frank
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  /* Export to the platform drivers */
> > > > > > > > --
> > > > > > > > 2.43.0
> > > > > > > >

