Return-Path: <dmaengine+bounces-1469-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B1885D57
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8BC1C20B4A
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF612CDA4;
	Thu, 21 Mar 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CRQL85y+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989212C522;
	Thu, 21 Mar 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038116; cv=fail; b=mEBcZJGvUFt2WM6ChRjJWGX2ecCzZjlNeuVOc4P8a9MynXgNA3tQJkACABFVY1S+I/LqXrE7KJTicN86EueW9Hi9Xy1fo5YqWlP6BbHz64AG4MJw0q4xaHjo4CITksrOjiTO1FCkVDy5QDyY82/k6tkql6nrYT6qZL/wna+/HSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038116; c=relaxed/simple;
	bh=0DprCeLuKeDA3tFvrNqJwY1dCz+OCyboZAGI2ItN5tM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ZxV89BiS9e0+kvHtZ7L2RwHXQaP+xqA2rycGbkNsXcIistZDSbbC60d1I8s6TgxD5LLEdjbxI4p8KZI/nYhTImcVFKv/utLWEGR3khjsjzH0v2VOYdBSlcH0Er+sFn5cPl6fUSu7w41L2nqoS7X1xkmyfmODqzU9KklkH7NmNeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CRQL85y+; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LERRQ6019230;
	Thu, 21 Mar 2024 16:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=bvG754yFnAr8/D2t/qRxXYhjYJPy0OHmhFCj8Fa0wb8=;
 b=CRQL85y+VlxuRkN7crJqGorZdNNp5EwW5t+mHoUYchUVxE4npYt85y8WVAZ8aFlksqBM
 eZIhcwjCiMTcmBVlUawC5qn1OKoSb9JXLV8uF56ZxcbgG6taGBUAOweJh7kyW8h3S4TB
 OXW5/JBC3xgyGBeGHWcRlMW1iHqyb576w9VxiZgXya4+SrPbGGklICkOkDZTodns7FRf
 b1r7LCpQgxqYf+lPrZzK4xlbfo5OSza86s8m5edeZS6MUzQQipaY1ijN/osMC01BF5vp
 BfLIi8h+5yFyH0AU5zdKNxFnW7qBCErXcmnP/pPaovpRQWEB6UeBC0/JekuqJq34r/h3 Ng== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww3ts5gp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 16:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f89+6+TrC/0FyrKkThHMt2V8JeYaTB4nUY7QCtgFqmmSuBIwWWheGr40cpMQmO6q5iMQlnaWcFwPN/K7G74pPCIKDFqJodHcDErsNIwZ47YqjE5Yt8oofRLLKB1PCtdfP6NXf/ohYSKOcJdr/CC3oGYrtl+xnGAELc4RsfuDjOAv5jTT5NX+d4jrGUnvLpDiAyTVupvcHx2lMnuQRfh+BCokID8AmX2vQ2YdQ8uW6WKytkA+XhQL/xovc1j0QmLW2DdBgZLzTFFSnDbVblIRsfqOLPgHSBEL91uHIJN5skG7WqMtrTHvOyQJW4v2cObo3ui7iHH38tXQAVUAXa2l7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvG754yFnAr8/D2t/qRxXYhjYJPy0OHmhFCj8Fa0wb8=;
 b=i7nZ6JwVTI8mkcl6hsIdefl9uZR3Tzqob5wTKoM3XqXnZnDCkL+T0lgdxYu5dYPrm4kby/SexPrUb4k/mRa9Xo6bxbeAkdWgY3ZuFWyco+qyk53azBJkSCWzVRBANDEKn7KUbVi5Mjlvj9rBTmGUMdqS2oF/fJZ+MQs75OVY0Q6cmX4S9b0gD3Xuzg4fim0ytB03LSpq+rmsT3bfbLbRyk0NtfY6/S+odbfxqGwUoEWNOTKyxjCopxp4FQxbDj1IWyv8E4Onn8uysDyUzZ1mdPNT7TklFCAe9XwPRY0yHUfN+ZdkrJOzCmvF5tJ7JvLxq2uCxGLseiunUD1s3XhWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from CY4PR1301MB2071.namprd13.prod.outlook.com
 (2603:10b6:910:4a::23) by BL3PR13MB5179.namprd13.prod.outlook.com
 (2603:10b6:208:342::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 16:21:20 +0000
Received: from CY4PR1301MB2071.namprd13.prod.outlook.com
 ([fe80::42ae:756f:fd0f:34c]) by CY4PR1301MB2071.namprd13.prod.outlook.com
 ([fe80::42ae:756f:fd0f:34c%7]) with mapi id 15.20.7386.022; Thu, 21 Mar 2024
 16:21:19 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: Christoph Hellwig <hch@infradead.org>,
        Kelvin Cao
	<kelvin.cao@microchip.com>
CC: "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "George.Ge@microchip.com" <George.Ge@microchip.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>
Subject: RE: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHaeV2YY1aquyBOkEWbZoiwjQWrUbE/0DqAgAKSLVA=
Date: Thu, 21 Mar 2024 16:21:19 +0000
Message-ID: 
 <CY4PR1301MB20711EDCA46D098C54A9961F81322@CY4PR1301MB2071.namprd13.prod.outlook.com>
References: <20240318163313.236948-1-kelvin.cao@microchip.com>
 <20240318163313.236948-2-kelvin.cao@microchip.com>
 <Zfo0Ta9cbD5PEO3g@infradead.org>
In-Reply-To: <Zfo0Ta9cbD5PEO3g@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR1301MB2071:EE_|BL3PR13MB5179:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UkIjkV1uS3jTJeZxRennJ7LL2PddRq4YmkDL8rpuBqqf97p6X/RpDr99IYP/e+H8rqqZCD4gLM75ikGMjWqJYAevr0haOYTy+QHq1yaqheHl0gGG9+ofc9MgORz8CA/9Ncij7fR9gzVnlykydqgEgc23h7aKsC5sIxE0tG9L7TMhMLUfsWrhiLCUhnenI3UZdBT/g0zL40Ggzj9tGS+EOHIIuU0sHKv9TlkunRTkndIkaNgCJWB6fdRNcjae26/TFKUN02E+QVCurcSxW5ks8jhJDuDY5uojnDU/kPu5OeIqYtd54qrmoAWtNrvRke2ogiKP04kttlibtVZ26nfwB7pCBUJ/iliZn9pjAkkxHP3V0EetCyckxuUJEsBBG9DwcLnEPFxvPdoLKr0RhiHCEANQbPdcLrJh9c+DtX8j0/M/uH07MxdxHzJS8ugY08+T/pqGS0b8CKvuDUrXg4L9xdH4xkj8a/0Qobacnjh6RMSDTU8sBd9gkZfolymqiCw1yKTG5qgoi0Uv48RqoIb49+8vhIJ55OySDzn09NiAmqdATfdn6JrbXooFnyARcQvVXhOmhenbTG4amG2leprf4ciTXYp4eudUjvuqrrdDXKfnJYVMMlt2/AwIz4e9H9xMgyqONwDMOxqdQbxRQYFvFB7VFKwxWUHwYnoOYee2l44=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1301MB2071.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?p9SsG1mkr9kmrNIOYNngyo6+dBqgWJYUa6OiVKOAs2F1mFCoGXApvvMWtGF1?=
 =?us-ascii?Q?lZ+Lm/HEpa9E+dMm+SO05whYkVsYoZFyBkEurnRuFgNkohBF3EITcyR+ZZrZ?=
 =?us-ascii?Q?Doijb3FDlFh607jZQKKiEF8P3L/c4aZCJv5DmqHV1dycsA4RUVl1xyt83dtt?=
 =?us-ascii?Q?VJI+RkbcxgXauP/RIK2bE6HMqRN5Z7MooiMhFUO0OFf8xrBOmW4U6m6WhVZH?=
 =?us-ascii?Q?HUO/G+YcRRHVn965jg8/ynKFdxpSrXGHO8Glh5a6EGZN+GHTsYKeZD4OR2Bs?=
 =?us-ascii?Q?Kjze4n2jufWT6xl/uQc1QYiBMoylOiZQ9cTEUZS1EDE9U8RcbB/wPqJX7TTM?=
 =?us-ascii?Q?91BrwG5/2hcVvYmJCzYtbkupzz4Q8ucObMKXe9ktFmnD/TV1pQ9vJ5m+uhF4?=
 =?us-ascii?Q?uuXPQCwdAU17eqF7fDDgVRR+Hupn+54mbVpG9PsBr6PJrGeIEOXN+8hyG770?=
 =?us-ascii?Q?Yj8eI0T9Q62KEmJ0JsEoAAR00bWJbGZe16WUHfMQd7Q/N10n90J5oUjbmyRe?=
 =?us-ascii?Q?M1GTCEtIriLpqtFr8cDSvWtJ1SLkOWHqSwCfpUoQ1Jc9B+hdLjbqDdWddM4H?=
 =?us-ascii?Q?WJ1jQHdzf2a87pPjXSU3HTVzK8Vi5Mkwl6Dk/9SS49VPxIVtIm4wo0TYuIJd?=
 =?us-ascii?Q?QWbf6jMFYG1DlAoM7BCwOhNfs0SZ0DAm9ndTg+/ZQVRBniDw8QOI874J3EsS?=
 =?us-ascii?Q?hdNTKS1uLmBpHVUL+RCQG7ZnUmCofXr901k/ahkMfyPeHqUJmGCsUmfvWkqA?=
 =?us-ascii?Q?1dRG5azV4r1mCWSvc0rQS0Q1KXPxi49Th2pw29PUfxRHGqS4htDNYeXux5Wf?=
 =?us-ascii?Q?qXUKafmg4D9FNjYMCXLCGoOIal/pu+DQWdJOWHhcandTIQnqQXKyPssv8skB?=
 =?us-ascii?Q?fKYjVb6wzknIzG9A66N8Z4Rgh3IHBwE5nek8DIhzBLwe2WY9+6KOYycujcxU?=
 =?us-ascii?Q?EYq4eBPkEuFKOg+vam+1l5snd9c6YDvUryGpmmbK6VcJfelf2MeJW+uLWI1R?=
 =?us-ascii?Q?YiCcVVYSvEd38yhktfA+QDNc+5xoszLkw/jhVFHlhrRiRsVFitRVdz195Lmm?=
 =?us-ascii?Q?M3HptE0SDENqPPRwvHgt1eVpS4wbg970yia6OaGEnSwITedOLMPVYgnaW9fO?=
 =?us-ascii?Q?JBdzHQRmc/0amcKaPfQraj04mH/oW0umB3ut8Y4qTjS55M/dUbvfAmweQFSl?=
 =?us-ascii?Q?JdOLgv+fs10EbnGrThyMQKsEVcAPy8tMuEOYamOj/R0jKltF5NUdDseRPRxQ?=
 =?us-ascii?Q?OR2J/dZjySXBes5Oe/oD+8SuPL0s1boPjJpPwjPjJ/xJveRv8rrghouyIBC+?=
 =?us-ascii?Q?JLioVWc5mj3dPS2y5dt+nmX6xxnbI4UVS0pBBLJrvYQehnfNMudUMARrhFHZ?=
 =?us-ascii?Q?utXi6wEeyc2JhH2kJWF3UNn+WcitXAo7zZvvlkxUewkx5VQUbQ2141ut3BTm?=
 =?us-ascii?Q?kU69Fh7qR3twLq+roCiV6kb+CUm/1yV76PN+dCOEf+JOwwxgQbZO4ugDtTMf?=
 =?us-ascii?Q?HPdyfzkajQw0ws9TUTYFv38SDQpzr8zadg5gkFt7+RnMkPxj7+PA4XJ28jr6?=
 =?us-ascii?Q?BDSJPsF7NmSSU1CpR3lT4+JwuBHAw6LEzqpTHpIk?=
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d7lvm4DnPbD7edkzi0yhLgkkjwhiCoxX519T1uOHvdrmXBT9v2/Yeb4N1S7ckh5qHySVp4vjKNapW4c6KF/zxyWAmCp2i61kSpIVRQ4x44Zam/DJCzbxbkDBaC50tDwXm/Ca/rs5Hru3196Bbxwpf5Z7SUZD/hVL0mZz9Ocz3N22eaa8iUPvtbjgHfj6Y/eC0GsG+25gYUqov46/q4Q0F3Yco4u1RxTcVEiFt9Y+nXi5MF2e+8vBM2unTXnZtzXxWD87Wd9iruPaLErSSFImnH8iCwQCXmo3VBXSWbB+FkdN7gRiVazbC/6um8JitJ+G/XvT5AqxVSX0t3+BvoZkpGmxTAMDODUYS0O3+GOqjprI1x+mhAk4uLx/auKq+fStTntMSL9EklWlYGUnvuQYgskGGSlMmiJ+5WDBGg/G3hDOgH/oPl7pC0sMzHQmVh+gedRRYHjOh2sZ8VXZkW/dfPxI8zHtb+E3uihBPGPw38PqSUWljPk4rd5+3aGnRNus3h8HCJx6UXqfnXKriZUbsK3zpO8wb4gHaCB6VbnhFuH4psWhA0hSfnjEUi5/uFop4iau9vs+P5QZ6W5l0wWVS+pE0G4j/OPeUDOaY3thCo8P1lM+Asv3qNPSPolZ0hec
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1301MB2071.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae89937-296d-4d6c-c67e-08dc49c2f0b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 16:21:19.0366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jt7PozHYGHZrf3HuN2231RkSvg6ntXxkWGmoXAysk8NfN0Qzcvn3AvddXMei/0uqQUCvufWww5aoJU2tvEDXZD87eEpX3DYzD6SOFTFc880=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5179
X-Proofpoint-ORIG-GUID: 0RerBBDLNsOnRiihI3kSthVMufV-zoKe
X-Proofpoint-GUID: 0RerBBDLNsOnRiihI3kSthVMufV-zoKe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: 0RerBBDLNsOnRiihI3kSthVMufV-zoKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02

Hi Kelvin,

I have noticed lockdep_rcu complaining about suspicious rcu_dereference ins=
ide: switchtec_dma_chans_enumerate and switchtec_dma_chan_free functions

In the switchtec_dma_chans_enumerate:
```
static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_de=
v,
                                          int chan_cnt)
 {
         struct dma_device *dma =3D &swdma_dev->dma_dev;
         struct pci_dev *pdev =3D rcu_dereference(swdma_dev->pdev);	<<< sus=
picious RCU usage
         int base;
         int cnt;
         int rc;
         int i;
```
And inside switchtec_dma_chan_free
```
static int switchtec_dma_chan_free(struct switchtec_dma_chan
 *swdma_chan) {
         struct pci_dev *pdev =3D rcu_dereference(swdma_chan->swdma_dev->pd=
ev);  <<< suspicious RCU usage

         spin_lock_bh(&swdma_chan->submit_lock);
         swdma_chan->ring_active =3D false;
         spin_unlock_bh(&swdma_chan->submit_lock);
```

Is going to trigger lockdep_rcu below log from my system:
```
[  296.678725] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  296.682890] WARNING: suspicious RCU usage
[  296.687017] 6.8.0-rc4+ #2 Tainted: G            E
[  296.687028] -----------------------------
[  296.691166] drivers/dma/switchtec_dma.c:1256 suspicious rcu_dereference_=
check() usage!
[  296.699263]
               other info that might help us debug this:

[  296.707446]
               rcu_scheduler_active =3D 2, debug_locks =3D 1
[  296.714142] 1 lock held by insmod/1536:
[  296.714153]  #0: ffff8881191d91b0 (&dev->mutex){....}-{4:4}, at: __drive=
r_attach+0x172/0x3b0
[  296.714207]
               stack backtrace:
[  296.718689] CPU: 45 PID: 1536 Comm: insmod Tainted: G            E      =
6.8.0-rc4+ #2
[  296.718710] Call Trace:
[  296.718720]  <TASK>
[  296.718731]  dump_stack_lvl+0xac/0xc0
[  296.718750]  lockdep_rcu_suspicious+0x1dd/0x380
[  296.718782]  switchtec_dma_probe+0xf0a/0x1400 [switchtec_dma]
[  296.718819]  ? _raw_spin_unlock_irqrestore+0x66/0x80
```

I think it should be also guarded by rcu_read_lock/unlock in order to avoid=
 such situations.


