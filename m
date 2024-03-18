Return-Path: <dmaengine+bounces-1432-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0A387F31C
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 23:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E441F21B43
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 22:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3F5A4C9;
	Mon, 18 Mar 2024 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q4OGZfZm"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2047.outbound.protection.outlook.com [40.92.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2958211;
	Mon, 18 Mar 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801083; cv=fail; b=Iqy6Mf5OOvXNklHuJENo+0c9tPCVhqGikcxGyMJXt19VrXnRSyl2qZ+BrxNhvm/vLvyFYL8l5NlpODHYOv6VhbHLNgqJRu0q3I/QsSAhsJikZFqaJz84D9cLlFWBT+BRm+YzwhtUFxIz2K+A42OFH6TipcS5SLlcBYfBKSGHjQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801083; c=relaxed/simple;
	bh=d5O4NLMEA/JX/CTZPyo+koWWGuY10Bt0pQ6+lqxjrgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zgg1G2wPTQ6dQtYRypaZ+4TVN3j75PdEU0wI7npLDwDDqEI4DJJ9WEdQMFWpnVFOTfS+YheUhEMS4F4Lb5vkZlHnPE1aHj1oZdeW30LlcYyNRLe/EtQkfmcT1Q9jlGjNRTH2xXeyTxuGlxsInMJgL8+fdz/YdnuKFnrp479ck4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q4OGZfZm; arc=fail smtp.client-ip=40.92.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSLidO+CFvWVWfAzgZ0BHQS2/AjaxW6/9Seknapo2dEyDdub3lLK3QcMOA+Egy59WsuCWTT6l+nOv8+ljcXbMbBtcHhWzvu5965NqXzbSzsdYf7qWfO420Tg6LUPJ9+pUgHZvm9DVILHvGUoM2hGrTzyWJLmeTgMC+ebzJEcnWDklxIB57XM85/aFfxpaaHBMQsmRPovCuVLlFIPlghdYeLdOzrdY2kjd+OaGqm8hEJt+Rqj8xE4dPDsiucemYlPuuixmu+bKPkOzo/sqR45f3ISp6u2QRHabb3Cc4mGkJQuuqLckV0TutWdBBTBaHZfoHOUJVI+4lox6tacvZLXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyPdaIf932MmKKJhCHKz7sBXKtaFNzWLq4EPdd2EneM=;
 b=ZeNoBn7zol9a/cKEzDQoxS4jBlJlxHRTXzRfbeM/gH00ZppOShYq/YdBQi3X7U7JBt6fApv2BuVXCo31jzD2ld5SxjLHHdnC7gBvgcsdLGSWIPF4JzMZrZ6Yo7ZMeiNC8RkfkMsN4w7trvw8wPSxXr0VgrcFMgPiofZOZ2fIWVrKzhFPS7EszvuT+CgykK2aQkCh6FHkcCH6jHgJblqWq6lJJJDvoeJeXmwUWM0+MBdxxsF7Y8VoW0eiRJo38B8/52uED8G4aFaK+Mjl39XFCIMw5GywKVH+6WF4l9Hn1jCXwRRUjuMVQj9vVzwqOI7Vb7z45ghXR0OOgWFQVX+nBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyPdaIf932MmKKJhCHKz7sBXKtaFNzWLq4EPdd2EneM=;
 b=Q4OGZfZmq11JIL/BliE7CPJYj42uEgpelHj85UNAGqK+7B66NQkTI7f3tF9iNXqNJD6+ELHP6VGTOu84G6DPdvT1fLEKBfbinC3PQWOjYyi98iIrK8pzDskBlCYmH1i4Tz0uaExhqYBV42FcK9pvRCai03yjLB2LR4J8gFBmbhSl9QRzFgkZ/olKgfZb06hu6r2lNOgnVDfknCvH4yIsfTAmcP37lfzkutUkZSOL2noXH8sq5PkD0/5UCtZQ4NARhSpWZHmMAFEZyb/zkZz2Jn0ESW50h19BPeNYaxiYxJypYbiBmtDxZoIUt3dZtJFsbprLxIULmw4c6S4HEllVcA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7304.namprd20.prod.outlook.com (2603:10b6:610:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 22:31:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 22:31:19 +0000
Date: Tue, 19 Mar 2024 06:31:15 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/4] riscv: sophgo: add dmamux support for Sophgo
 CV1800/SG2000 SoCs
Message-ID:
 <IA1PR20MB49530E879C1415DDD9680D07BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <c312d643-cf77-4a6c-8368-bc30d1e54b4c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c312d643-cf77-4a6c-8368-bc30d1e54b4c@linaro.org>
X-TMN: [iNfowU2Y41ZWco1q/97yTFPuevjP62CxX83VuEglnt8=]
X-ClientProxiedBy: TYCPR01CA0170.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <4e7gpdqduv6mtxenagddx7atq5darrlmqkjziqigv2zxqhtk7j@prk4ifthcn4m>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c28bde0-960c-42d6-91e4-08dc479b21db
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qUQWS8lN22nUCivNlPfDo3s8kxTv3+hC8u6wWb+oytnlQO+16SR/+JoKwapFgBeOYyiPm4Ym39fE0E3UOjAcXV+xCQdqWaxBxia89wU2nSHDQ0K9d/CpoYD2y3FBkZmQ5J3oJb5e5QK/xB3piMm7Go5NMXYORPCZNZa2lh2I4h9Yve9ci0srbZTtutJ0YiBz32xshN4+529f879xuGlKItyeBw8vigPk73bNqq9Z1BEyWAZTPgXUnWEEuVFIKMR0HQX9BoMAsN4dH4eoroBZkJisOwEcayx4JOV9kCSfqsPbz5Thixz7lvO79oUQDkrtV9dsB6fKFfXEx/5QrWTHPOikDn22EBLkFC93a4qzWr2iTNpGg5pmcXGamzS5I0qkg8qjHo9OuccUadZTBGqnCyy+O77yJfop4sXzTDKaSuoP2CPKWZBD9uTXPlxGfLPWI7H4iidMCQQ2pb41ngZgtpguPY5tRsGpwUKtmx7q3m3ZiDO/ZlnDejO3wpVFOdFdoVLXest5Fky7EvTKdsgzqGhAu/nJ1sJMiZzyDg+wkO+SfP0cGIOJlkg7t4ZHEHfxErmsyXcDljq/LrqVghyJ5OtXekePcRWLKtTJ1kDDIATQ3G1IORLv0p/w7aD6J4QNrcxHRFuZRmNVq5zxfw79Zk9bsA8YA8OemMp7RURXAIIGNweFnwaWmzSU3OCILqr8JV30TVhSusW5IaF2NyFh1gCrW6PTvBBbZLKe/tiZ882yKlx2KIdQFh9fVFac2XUtUc044bB+JX3+ExQXK3rWKntAC87LtLo/ZAVBzXNuc9zovFHGwQiXcm+yagzaBk8zON+uUIhn4VfdE7+P/Z0w8nK
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9lIDvXg97p7RsiU6OfFWc8c7/KKQnxCXhIjQxRdYirl9tmF5guQ7RzhsCOqX98hUhBLdwvHOBtzcV/ZbXBOh677DkgoR6/PxSBBY5l3pYtHTknu80ZeX9nKIHtEnJWranhl/m8+QwpYOznnEHbQ2vI9pqhjcY9f+l9yQdGq4j+3JvN6LX4IlB67+UJfW+k1Jnsn+eqg9t0Jjt9NFV10x8wyTrtQ5spOKc1XfrUnAB610cQIhWhMVuKx2EtPKReIhR/yWyexNrfQILobIV9gti3K537XCqYOSEDM6EtqqlXiNjFOd8jzEJXtFiAv2HfbzEzJ/7Plvd8OAfDHgSIUCRjXFBOjMygxVI7uqf/9v6eHIsQkFSswPfflDh2lh+0owf28AMGyhuLGWAepAWyKMFU/8f5Q0XLV1/4Y1euDAtncGOhzPww2/vgukzTHlBXx5g4FPq9NOUfF6gjBnqb8mSy4QrgbmhhbKu/yejVCYKL+ba28t72M91/3dJ1QTxGT1JtrlvKeFctFW/SXGRCdXQkmdi4AViD9pEtSPjGWCaUjGb5DEVrGw+On4ivgVOJLdnT7cRronZtGFarjmqNtKkeWOv4WWBsv6TxRgi52vfiw7byIHtwVwoIwlv6jzEJCjju6ot+SGYSW+GMfp+2aee/3md0MTPAxF7QE3iiLtICWhJBbcWacu1lJXslq8eacL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nspD/VbLp9TThLKwdD6APSod/a6uyWyG1kCXW5hgFcIZW8IsF5BCOOtqcrmz?=
 =?us-ascii?Q?9fIW2vL+JVWGRhAu2r+RM3Da4RTNusBYQFFt3H8tS/JkNEgGLggZ/dBIzUIu?=
 =?us-ascii?Q?Bi9oodGYy76CuVJtxCYhwTgGG4AzNlEUu5tlq9x8V6GKVtQOttA2sjp+lFbj?=
 =?us-ascii?Q?mGgFS4q/c+BGoS96jeByHyPtRve4TNGublX98qYgk9JAKTWNTeM+6Q2LmIIw?=
 =?us-ascii?Q?pwbO061Jvb8/RYsvS1pl3y1mhqeu+5uhud/tVC7kP5X+nWf/CqFmFE/pQY48?=
 =?us-ascii?Q?DcNn/OuflxvdunmF9JFyyaeX+ysPfF/d8h65yaanjTO7uYdVN8WcMjYi9jRY?=
 =?us-ascii?Q?05NvdnqatS9d6SBRxyEUWwi3e5h+Y0TXni3vFpxsQQQgAxUoUCHkVbVAiVyt?=
 =?us-ascii?Q?P1fTjefDeJXm4TDwtIF8ahtZO6eGNSag23Szsca5lzWSlN3BFGKQSV5I6UJk?=
 =?us-ascii?Q?m3RxwYdkivxFcxClCVZDhefm2Ywnb4mLaMrFKrnewpsFwoik0O7rWTu3lvNp?=
 =?us-ascii?Q?M62H/ZqqBy4IP3JPf8i9CBsN6SKE1KmrO4IIYEvuZVlPG6AplEOUI9NTs0h7?=
 =?us-ascii?Q?OkzZjVGsnBhUX33cKE4j9eZlCUi9t3KiLglw3DunUutbdkpQ0nfpWB7OZBpw?=
 =?us-ascii?Q?qFbCQ3o5x9rMEL7ZLrXIDf0POAVRXaqWCj2Ha4S6CaduifG2jHL4wyb15YWT?=
 =?us-ascii?Q?uo0YaAdVu2EYPMQ/Car133D/PtdiUpmpGJzNqMjyW/1n1CmkdSCAZAtzREix?=
 =?us-ascii?Q?ck5Zldx7W9ImEtt1h0/x1t0xmJIUGI0HOYCSfRzuuJqnKPoufsyHhKRiu+SU?=
 =?us-ascii?Q?HaDpUfaYqlnjjcM2+ow+G3lhnY4TwruYi3kngBVZLw6bUkS/ORMDo+NYm06U?=
 =?us-ascii?Q?KtOBAIt78y2fiKCsBecdavR6XNZcvUojM5wJAjO6hBBMLsN7fzpQoHzdMFwp?=
 =?us-ascii?Q?Y3DHw0q4jhfl+DrvUKL/fyjJtutW9zBfTMW6Qeh8U/fQm3cMCEL3eYeEA/29?=
 =?us-ascii?Q?TQsFkn4gITo+kaXVqmKthsQnh8NDIrWZpGHCasNiJfYQrQjRIegZKdKhxArl?=
 =?us-ascii?Q?SmlAAj7cCkjFBW8+zBGASPjJ8G5ky3YIfACYWsDbNJduGJ59y/EdXF2L4CLv?=
 =?us-ascii?Q?UMjLHlvXFFbRB9eEFdCw5JgGwEFGOYffInTxWjHM54tPA5q6W8zl1vhHnzLT?=
 =?us-ascii?Q?9agyqpCnirf4NQpNgwLDW4e/dxFr47pLUt84M72fTFSmkEUzukfb27Zr6nXg?=
 =?us-ascii?Q?PmOV1+VAECBfH+IHZRyY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c28bde0-960c-42d6-91e4-08dc479b21db
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 22:31:19.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7304

On Mon, Mar 18, 2024 at 09:06:19AM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2024 07:38, Inochi Amaoto wrote:
> > Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.
> > 
> > The patch include the following patch:
> > http://lore.kernel.org/linux-riscv/PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com/
> 
> What does it mean? Did you include here some other commit, so when it
> get applied we end up with two same commits? No, that's not how to
> handle dependencies. Explain instead the dependency or combine patchsets.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

It seems that I missed an important point: Is it suitable to add
an initital binding for the syscon, and add the dma-router property
in this patch? If so, the dependency can be resolved and I will
maintain the syscon change in the orignal patchset.

Regards,
Inochi

