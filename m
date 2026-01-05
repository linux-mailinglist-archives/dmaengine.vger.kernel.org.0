Return-Path: <dmaengine+bounces-8010-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD38CF3028
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 11:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7D530213C1
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 10:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393152DA779;
	Mon,  5 Jan 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nlqcCwgS"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D42F5A24;
	Mon,  5 Jan 2026 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609340; cv=fail; b=kKZyaimL66qud9HL4u1BbXNu33y1d6YBdNMScGjSPN+/rxroFoOAGShhTP88CMrmauU+CWQ67CzoHWax/OmI7EQ9uuT+b83zA52fIm4gimBP+HNkfwGcb8ry7N/wmHa7PkkaLOg6EhSbHBgVMSnoVt1hIQswE5r+2uYlQAsWPHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609340; c=relaxed/simple;
	bh=w8Ng5qyv/v8BgtgeXYCVQ30faA5DlMc5jeyTan0cW/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ldMGEtiwDTNZqf2a+UVgztL72TYjKNmFUsazaskflcbI5pobg+Z+SAHNmN4gSU7N90ZWteLs84QEG9Lov8GGyzsyYI8Be4svL0wd6VO7lNtYQy+6lKg4Jj6tlq7sgaj46gp2EFxZIgX2lV/yz4seiCAN3amgEIAitlxtowTe+JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nlqcCwgS; arc=fail smtp.client-ip=52.101.56.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFBRGb4hUqKW+Dcxfi3uSC0+BKEftMxdUmx8aBktWRjDeu5w+EXb3QvyZwwMVpWiZJ+dKdmmtswT7SmiwcrXQXmLgVEHpiYJxVl08XHeoFVo7FHPHq3SZTgpjFNeoNzJb3sYa7SZJdYxNO5jZHyDZ8Lg6nu8mhI3KLm8DYpZzvyOQZGnAHyAs4ehJWYIEJYmlf6/sXdMqztpEXJsTTR9H0FgOiVbhQ4E3+JC3HeJ/7kxVKnqjYCMkMQ0A2w/Xjls/LGoh1ska0WMgj6I7UdIjNoYW2wv1di8rRXJMV7qBmZL5eaO4YMivwJ5oifn3ghZ6pPYktYadv48mfEcc9UEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Uw1GrVWPnA7+yu/t/EzavbRh+CdisFLphzpXoa9OG8=;
 b=Gulr7bQhXzBbFNaY/Je7SpgJYH99gqmeZ1cnDQzqHh08H5CDqS/11zYUyg3jebLGaxx06U35pUuBNtTV4x5ujRvVnYqjyo4703LNxOKZg1NQvMIZZY2o22xf7N92kNqivgB9uRqryGXGxL34XrdE+BY9QJgclPqpZBWBZtHufymk5cYDjE0JsPZRGPdGd1f1n3cGr+23Wpz+On4VNC9pyTKAcaaWVOiMXh9a05VUhZpntT7xWoHT6ho5W1vGBIAKAUmxJKbI9MLuNc58YvezwEouLkNbmYECrfaTD/QUBAYW7e4k3HpfqJGQt4ENuc1Bw5qS6eXLmkmX0xByUfFiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Uw1GrVWPnA7+yu/t/EzavbRh+CdisFLphzpXoa9OG8=;
 b=nlqcCwgSWQp0eKUnHz6dY9UY94dB1popb8M9A1Tzfatv9pgvTejRIByitjuzRYdyFWFXS6p+3biSpKYoO1UnCUDZDZa/mRbLQVO7Q5vyBy6Mp1/TaJD4siK6TYVaNew53gF91qBcPN2FR/tI1UjCZMt/IimI4+jiJsCFcqXbLwU=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:35:34 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:35:34 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHca2HPzgtqx97sLEy+fRS/FbbYFLUkORIAgB9IBCA=
Date: Mon, 5 Jan 2026 10:35:34 +0000
Message-ID:
 <SA1PR12MB8120F3D5F2EC5CFF8BAE8DCC9586A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251212122056.8153-1-devendra.verma@amd.com>
 <20251212122056.8153-3-devendra.verma@amd.com> <aUFRKDCglF3NbNLZ@vaman>
In-Reply-To: <aUFRKDCglF3NbNLZ@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-05T10:13:24.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA1PR12MB6091:EE_
x-ms-office365-filtering-correlation-id: 8b5752b5-076c-43cf-c40a-08de4c46289b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N4EjRMuEAQ5sQCYYLh8KMUzHJcQdTadwoNzbsLtx4dS0g7zGT7BLEtSLqE/N?=
 =?us-ascii?Q?RQKTXyUTrblV5w6BGsI7zoKo/ZjwT1qd3EPRKHnab65nEXWkP0dZcEo4rXOS?=
 =?us-ascii?Q?nwTLMoZzXogu19PVJABab8fA/gIU2OKOwzMqbs6nsuSXUwB6H6I6POg1RW2E?=
 =?us-ascii?Q?z5lIEu1qvtRREW9q83c20PE/MNjimG47QGyhlrWp0mpNbDnX0GIVSGg46gcV?=
 =?us-ascii?Q?tpr2BrfIJXOp3L8CdiA8Yv8aPa0ExgDNOr8dhNa7bGhqhVYLdTDe2npHnte8?=
 =?us-ascii?Q?ka9P8aGheRN9o67Oi8sx+wYvFBZ4P3DGmW03XXickbqhW4wI/YotsJLF6l/r?=
 =?us-ascii?Q?2Gf8ArDcTbNMQgqwBKnBfU3QhWvujSNc8so3Vib9cldu2cCkDMcmKSfhxpR5?=
 =?us-ascii?Q?Thok1euuyrh96uQftlJzzuoui63CZC/+PTFdvQ+5vQ+mt7UfJlmcsAc9uUSx?=
 =?us-ascii?Q?39XJQ6dletQX/HQAU464WTccPTY2C39dsYdj62dINSP9SOigTe8fgMII+KtJ?=
 =?us-ascii?Q?wYNhVXI+JY5oCT5EvKPaB12eTamsPMl5+A97DKmwCpthCTZnvnHP+S3hKNZM?=
 =?us-ascii?Q?/XsTsKj6ZiBTDKQYLf0NaNyg5swOuB7EUOnvbto3gMDM1j8b3+1LxGA4hbtn?=
 =?us-ascii?Q?tUQzLAwKq1EVOx9EDtf20R9OKaPRtL7qjQo7Lnc1XTEbn6M4fSf3wAbokymt?=
 =?us-ascii?Q?UlbckPMeKmolXpPIe02GlgyX1UdhWgAN7n34Le91yEriZj76aZSNkXOYABn8?=
 =?us-ascii?Q?Hbz2/gtzNImz0fV3917r5kphdo3yOSK3ANJc1XksplqawZ7nb8bG0bTDmwdS?=
 =?us-ascii?Q?pW3vBreTc+IFP7uNsiKl2yWH9Wcv8kaYZ6sgcegR6khVpsgXIqERLnU4aI6e?=
 =?us-ascii?Q?0m1KL46+fS592sdnK36XkHJDTo40HxFCAg2Z3VGhk1Fg51iquZD1gJRqmNOb?=
 =?us-ascii?Q?XRfDT9v0n+6N4udYVa5MLU4AgIzywpYkXgn5+91U80rcb5JOIeL7pN4f/TT6?=
 =?us-ascii?Q?Pj0q9+VIsjIaXDZgk5iP1z9ph1g0jR+MhCYHBqKNKg/zVzdDZomrSy5VQdP+?=
 =?us-ascii?Q?OfaBY6mxuAUnTpW1o0ngTWnASWdx+hpjWrorfCeqtrpfHLnJmIgUERxjF9wg?=
 =?us-ascii?Q?2rpJsVy1YvnSTQ+Eszq09r/g13Nlx8+qpiY2+bGmjAGE4FwwMV/B/6lZQ1oE?=
 =?us-ascii?Q?jv6rKesHGMjepB22TOki8/kCx7u9msXZsAJFhMfqJwx6/4NPn4OmUqGTnLIJ?=
 =?us-ascii?Q?NfGSatNMp7Ct/7Y6heRdB2TvwXIprMYZ5D486K+yCuq+iEd5UxTKILb+QRl8?=
 =?us-ascii?Q?2B5HHf2wPi7mkBjdUo49ttaDeu12pVWBqHdly7mZlOo/rsj55FGs6RXLNTAZ?=
 =?us-ascii?Q?eE2ACsFCburaGYmnSR7D409jN96FD3Ozv1JJ7kdu6NEZ08f5oQRtUmR4xjUf?=
 =?us-ascii?Q?paLiXE0a9Qynz0mi7Odffi2sKKDnqGWPiihk6SlWJG5oMU/tqy6bkpsowLSY?=
 =?us-ascii?Q?WtJfhwdDOt6/NXTzKBuVgLF9Vm/Yk7IDQhxh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PKGFPRG5UES/XfTH33IJBM6L2hNrEMfLErz36L43sb1zI7A9YR1i2yD5rRyg?=
 =?us-ascii?Q?kuErneCUOzlg1gYSX3b4TX8EMLJGK9isFGLC3qt3w3zkuL5raJYNNFvMPR6t?=
 =?us-ascii?Q?7guHYVsG/3Vo0lDGP6sbcNVcCFrMfpEKULtHjE5mhrDObh5P0StB3HgnyDmL?=
 =?us-ascii?Q?Xxcd2DIRVdKF19HLxKvk2ymnRIlQExQuTdtj+xltlR1Ir/X1jVbBa3IYLF0g?=
 =?us-ascii?Q?3COor5JDo1RcynTtNVZwrjDqvRrmp9og+miVl4dT0eWM8hFkMLZ42TKttZEt?=
 =?us-ascii?Q?TNiVyw/g8ndL2wc/DkrGnlAd24MFRNyEiwyv2YO0fQtsxbCIGqrPpQmZiycG?=
 =?us-ascii?Q?kX4n0338P/QIR/tNSn62Y5qbPfUu55RLvdOWF5QCrzinqnjl16cSKcvUcJzB?=
 =?us-ascii?Q?1Ou2AZZD8yUsN5JLv17yYqoGgw35lwyfNoZ2puE8EycZyxbVFL2WRk8duxQa?=
 =?us-ascii?Q?Ul8axabABpxTFSb8uJ3h1AEOaYbk6brH2mV0UePPW453Y8CfNHl/1poYwwJM?=
 =?us-ascii?Q?u1x7+Y4PInOFnIxpGcOsR1Qymkp7RqcncORLapxayJqMQyWffILW47Kz2Z6t?=
 =?us-ascii?Q?kNbj2b3F7vJUAJrXMUSEEChkMNafGvj6ooNDXDzLjbuNXwDhW0EkK7sHsd2V?=
 =?us-ascii?Q?3yhqYCZoneS1lr0qEM1+O1FnhtGs+zGKRVVEE1cxK8jdStP0TvbuUWC2Fy4w?=
 =?us-ascii?Q?NNaHX07vDuGnkmRSKBfg7XxxiM0L8nb+FMeTrZjT3AOVahCrYcr0SMp1QQ7c?=
 =?us-ascii?Q?qPw/uaPAaLjJxDfecqpUxLRunP39l+bmWfDHdPmBzb016/TmXx/Ru1Co7BP9?=
 =?us-ascii?Q?pb8v9T4uhh2sOKwvc/4dMck51DitltlcAlmGuja+rX930w+P/mDb1QqLG49u?=
 =?us-ascii?Q?Tw7oWPgE/qg4tVbSWktT7aK8hqE72w8yENDHWV86NsKlhuBQCbUzF3DyD8iq?=
 =?us-ascii?Q?Z18yJX1J4V7hw96wJcEIwaAb887oXSAI/B9xyDLCRgmJyFCItMPkxu6LLWfJ?=
 =?us-ascii?Q?z54yqJvBeX1psCvGD/T5S0e+XDfYuTpecYZcb3oYTZLY1a3ci7gVAAubW6lU?=
 =?us-ascii?Q?JsO0wW5vcJKMu9gL4D8i9hQa5Jjj6iW9CN4Lk7nmBKlbY4oNakxDMnC8K6M8?=
 =?us-ascii?Q?CcLQDHFZoTjWunqQr0JCrsBJFOtA8nyyIIfonKvUztmKhyLHA4tX5oz6M0+3?=
 =?us-ascii?Q?gmyonCgMMNq7ToCTmlEPcu6bWKCVmgdn2HpNPSWp2VRvp8JLcZ5coG6LGeE6?=
 =?us-ascii?Q?IInk9o9Bcp4B386JsKTN2+cQiCyGDG1SB58iMExIrKipOfJEbTEBgK5HJCUD?=
 =?us-ascii?Q?cb0b2jRFmHRz/RhEqwZHhqAiYMlsb5Ydb4vuPViqrHcHRpjNbjDk6es3x4G7?=
 =?us-ascii?Q?3KMsoUEwUU9a2IZMIDB4zLRViBWRJrkxGPpGFKTjDGGlpfGBMZxN6xdUwx7r?=
 =?us-ascii?Q?vnBhpsmOvAMSfIN1JqmzdEr1fSGkNE6ET5xnWmaXG7CfG0mnvugg+A1CJB3F?=
 =?us-ascii?Q?tIEB97mAO4c1S+qpJsiRqtjd+ORZE9Wg/tKr3oprqTBn/P5ahFxB/qHv+3eB?=
 =?us-ascii?Q?VEPVfbXkRTWKQaBwMeWc7mByB+X4+Bhx4aIXbdZSrQ8HibHwfsCVQb1/HbXl?=
 =?us-ascii?Q?8TKJcFbbDSdPLYEb7keL/UeaJOHxp5J7lKauSs2ezeEL/XAl5+MxuFFhq5xG?=
 =?us-ascii?Q?cmez/q/scjoY9MEB21n6F9VVt7ZukeopgPBo79hfcQTVfGqV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5752b5-076c-43cf-c40a-08de4c46289b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 10:35:34.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUXLFiKYIxef5G0ulwSbO010EjO+F1AJ85wpFTbs8y6RBKUk2WuGJQRP3RWEXBmwJnzSjOsnXQAdTyMIRurrEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, December 16, 2025 6:02 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; dmaengine@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>
> Subject: Re: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On 12-12-25, 17:50, Devendra K Verma wrote:
> > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > The current code does not have the mechanisms to enable the DMA
> > transactions using the non-LL mode. The following two cases are added
> > with this patch:
> > - For the AMD (Xilinx) only, when a valid physical base address of
> >   the device side DDR is not configured, then the IP can still be
> >   used in non-LL mode. For all the channels DMA transactions will
> >   be using the non-LL mode only. This, the default non-LL mode,
> >   is not applicable for Synopsys IP with the current code addition.
> >
> > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> >   and if user wants to use non-LL mode then user can do so via
> >   configuring the peripheral_config param of dma_slave_config.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v7
> >   No change
> >
> > Changes in v6
> >   Gave definition to bits used for channel configuration.
> >   Removed the comment related to doorbell.
> >
> > Changes in v5
> >   Variable name 'nollp' changed to 'non_ll'.
> >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> >   Comments follow the 80-column guideline.
> >
> > Changes in v4
> >   No change
> >
> > Changes in v3
> >   No change
> >
> > Changes in v2
> >   Reverted the function return type to u64 for
> >   dw_edma_get_phys_addr().
> >
> > Changes in v1
> >   Changed the function return type for dw_edma_get_phys_addr().
> >   Corrected the typo raised in review.
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
> >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > ++++++++++++++++++++++++++++++++++-
> >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> >  include/linux/dma/edma.h              |  1 +
> >  6 files changed, 130 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > b/drivers/dma/dw-edma/dw-edma-core.c
> > index b43255f..60a3279 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct
> dma_chan *dchan,
> >                                struct dma_slave_config *config)  {
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > +     int non_ll =3D 0;
> > +
> > +     if (config->peripheral_config &&
> > +         config->peripheral_size !=3D sizeof(int)) {
> > +             dev_err(dchan->device->dev,
> > +                     "config param peripheral size mismatch\n");
> > +             return -EINVAL;
> > +     }
>
> Hmm, what is this config param used for. I dont like people using this in
> opaque manner. Can you explain why this needs to be passed from client.
> What does non ll mean and how would client decide to use this or not..?
>
> --
> ~Vinod

The above statement can be better structured as following:
int *non_ll =3D (int *) config->peripheral_config;

With this it shall be clear that peripheral_config is being used for
referencing an int type object instead of dereferencing it directly.

For Xilinx only, non-LL use case becomes necessity when the physical addres=
s
of the device side DDR is not available or configured via VSEC.
With non-LL source code addition, the controller is still usable unlike the=
 LL
mode scenario.

If non-LL source code is available, then this simple config gives the
flexibility to use the controller in non-LL mode when LL mode is
enabled by default. This config is applicable for both Xilinx and Synosys.
The dma-client can provide the inputs via peripheral_config param of
dma_slave_config struct. If dma-client configures without any
peripheral_config as inputs then the default mode would be LL mode only.

With the non-LL mode, following are the advantages:
- Non-LL gives flexibility to utilize the device side memory which is being
  reserved for link-lists for read / write channels.
- DMA transfer performance is better with non-LL mode for single big chunk
   than it is for LL mode.

This simple addition gives the flexibility to use the modes depending upon =
the
client use-case without any effect on the existing LL mode functionality.

Regards,
Devendra

