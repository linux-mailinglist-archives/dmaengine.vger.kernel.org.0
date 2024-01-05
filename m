Return-Path: <dmaengine+bounces-693-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D00B825AC0
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jan 2024 19:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FD3281D80
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jan 2024 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316913D3A1;
	Fri,  5 Jan 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OtiEQ4Md"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759F3D38C
	for <dmaengine@vger.kernel.org>; Fri,  5 Jan 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3SI8zxpG0MEQOV8ixMlXjFx0ycjC+dDjdA6BkU5TWRSOFdqShzYvsJ0uO9BMKRqn4f5j59jplhBkrlx51EeV4d2xbn7AtMUNhlVaBLFL3qnotx/TcjiQj8bQgob7fQNYlW4Y1gKemTUhkd3rnNDtPhuO1pFG6i6e5pwxbh9nYu2/IgTeltI2VyBA1uopDkPW3xWSRWWuwY9lQhTCypxfjPTPILDN3OJtEb1JVqljvZz4M1FoSUvQLYDFKBuuC0qeqM/GvnZjJwY7/Ebw+pHLe0przmOg4D3agNtCy++QdBJhHgxvB3mwc5VNsOo8qMYpW4sRquTDBBo/19EKNHviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW8GX4Y0wD79Q4gLECr33oJzfZzOaTs0vveSw6K0Oc4=;
 b=XoK6UOMaVzlabyqMnIdc24qZJr0nssLIN391Z7Iy9ePSVtOwywFG3zdr8igRozxSapVaymDHtRxxz7CmaEayn42mYLYGh1frA32i16GRQrA2Hc/wCZAp78XJTMiw+WxImxeWzsaluDF6oA+aDoZb+fNqhCd6itBZP9fFgJPN5q5tIdHBWPs2QqIGi6rCotnw2Y/r1sSBPQktCwcfVXF2+u8SHb1/jQ859AfDuHwUHmX1GZf+v+o9UgglI0sYWh9REJOaLgKM+C/feAqUEK2w/vN9mGr/XdGSATr0pJBTeAoejRCWMXJ3XEY4Lbq+ss2xsqEU0TKXmWb2uyljkHQJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW8GX4Y0wD79Q4gLECr33oJzfZzOaTs0vveSw6K0Oc4=;
 b=OtiEQ4MdNFX0wW9HlT950jt43nXCfPYi6KItgTb8vNS2wabV6fhBXGa8+YeUvIIbGcKsba72EAJmPwwtFkqSwVTkPLC6/GeEQPDPRxR5RRJL/Vd8M4PmdlI+TnYR620OCc/kZDKSiptz5GJbLHJD2tnAREyVqJ65uJE3IJNgzMo=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Fri, 5 Jan
 2024 18:48:01 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::aea:c51c:23ee:6b49]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::aea:c51c:23ee:6b49%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 18:48:01 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Peter Korsgaard <peter@korsgaard.com>, Vinod Koul <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: check for invalid vdma interleaved
 parameters
Thread-Topic: [PATCH] dmaengine: xilinx_dma: check for invalid vdma
 interleaved parameters
Thread-Index: AQHaQAey7qs4CWRnVkeicKGguwu76A==
Date: Fri, 5 Jan 2024 18:48:00 +0000
Message-ID:
 <MN0PR12MB595393BDA24914C876750D05B7662@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240105105956.1370220-1-peter@korsgaard.com>
In-Reply-To: <20240105105956.1370220-1-peter@korsgaard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: ded2ff47-afd7-40e0-f4c5-08dc0e1ed7ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vBwzKoCoSjNY9dIFIRxUF/bxfKkv8992zk5NSskgZJUyBeFvSJhbav4k4XZL3prmolJ4reVYsiygs/pSNQe6a9wuiGxr46RjObEeqxrhysX3jB8xfhBgCB/bIXGbo8EtKu8dzVL+4S+AGKhpslNSQv1CWIZZtHUEhJfODMRh0p+beM7h53OkSZkBfNpLNXAVuK5KmBV3REuKIpCe5yWQKfScs5q+HnJi1IUD9PRyDVw2XhpdOYkQNK1QnemG4FZcZsHUtcZxH1knfoQCUuZtgjFnIHFLc+GVTF19750yAm4xcrGc5oeeRwNY8riXThUReD326rUQTS5wnwGZGxbA487ErouBbg8Qq8tXE5QGspJ91vKqlcmCCyrTSKALuQiqtMptHB0h/9xCuh+NiahBrqKCQFDBgaYnvXeqNS2MDumpkWMMfqiX3m+2oGdMrNiCbattHni7cL7Z/sWr+uHSOYwBU3WemTm7TM1+KsHs08DZfqOl+M58L/s8GIa0qvScjTCdkvV5t8p26Xxs1PqwaXIVV93QNqFoeitFTk8VYFPLHjiSqSbulc1TdNu0u8FNeqdu6PXKjhaxiBjRKeVQxVvpfDsdqwJdggTj1ppA7ciWmDjhv1YwwESelDdfwLpe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(71200400001)(66556008)(122000001)(83380400001)(38100700002)(110136005)(66946007)(76116006)(64756008)(66446008)(66476007)(478600001)(86362001)(5660300002)(2906002)(8936002)(4326008)(8676002)(33656002)(52536014)(55016003)(38070700009)(316002)(9686003)(7696005)(6506007)(41300700001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rZMBy0t0t7B5CeAV92/2Crse/Nx7b87+Jyx3k20qx7A36qTmFQg1ARekbReL?=
 =?us-ascii?Q?YMxu0z+Un8DkgQcb4Jyph/VRFQ0dC/mB9qGfHBG5huj0opV5PubCk7w6DtZg?=
 =?us-ascii?Q?BuTJEQf0wh8VuOoyyyaLCcN0VyJMNjRdvkN30kcRFYMXqRXEtbr8HrOtxRZl?=
 =?us-ascii?Q?ymkXMupUmxA97cl879H4TTNWv5F0WyZAyzHm+6GwHKHr/31UMtObL1i/gXlH?=
 =?us-ascii?Q?Y0Wr90DtoCNgFEtWmKcegs5S1X+fMKeqUupj3WfEc/1Gvq1SxEf4vhIwz32R?=
 =?us-ascii?Q?3IO0WMej4rgKrCyeJ1NBCi5jpyEQG45k/DOpQeYlb8XpUq+ZdmHRqDB7qbIv?=
 =?us-ascii?Q?nqHENPnK5E+bMW9Vz4iPKaW1DeNEwK0SydwnMc/eA6FritzNNE352vXtiSW7?=
 =?us-ascii?Q?IhNzqmc+9Rv6xI35xp13Dz0WndFxu5EF+HCAA9Nl0uLq71G5ACa8OzChEynX?=
 =?us-ascii?Q?BzEgWF/MlW1xXb1ZDUJIL/wHrApWvgNT/Z+PdUYA4/vj9Uz1+S4DNugEiV/C?=
 =?us-ascii?Q?Jq2QZlEBpd6nflUO2UKMgGIrbeESvUohLmS/ZJIMJ9QFlKgBP8HYQYwM9SIm?=
 =?us-ascii?Q?6eBvN3Irr3BqnHuAixvUCpvBSmlgNIIpMIpOSbuOvke/dW5PTiYf049BcJHV?=
 =?us-ascii?Q?NPNuUzfW7h1j//Y0/Bf2nmo+ACp7D0JD6bLGh8QuBC1neT1/+84AnJmIsRrt?=
 =?us-ascii?Q?Fa63BVVqJXSbBYCvPj8D0NvMuxupzbeH/7HKKzxrL9w3ZFORebFpPNsrbvPP?=
 =?us-ascii?Q?ocpDrrkc6Lau7DqA2L/Icg2XBNUeHyN+ucrl92BGvlaf5/Z0gqmXkiWL9Gjh?=
 =?us-ascii?Q?WXaKjjSuOGN/pzE7/lZs5SWrwjBdS7buzSgCtCFfXZki42ICwchctBAnS+Bh?=
 =?us-ascii?Q?nj9C745YSFF0C9PlygjmzPoH08Nc9Z8sdhkA92jOdL+roDsxIqr0LPN5/Srb?=
 =?us-ascii?Q?uqPmsmA/KyqlbC28dvKQIJBaCq1//8RB240UrwGPLcAmQeZIbkkwlRvb4Zkl?=
 =?us-ascii?Q?/oAbyYvqONq9ZVprVVaSEg+3Z+OxcjYbGEIU/J2CRe6A6IX12OcMAOrr8giq?=
 =?us-ascii?Q?hp14u0fQWYwNQWwegCiKDcSNB7arOovL/ncYLO4+z59LMOkR1aZXN/3RKyUD?=
 =?us-ascii?Q?dLLPc67sMj6ao1xz/tKOogPW91jC6WaRwM4H7TTmX84k56MQkAXXW2Jvs+o6?=
 =?us-ascii?Q?xqIDN7A+FRKorELU7L4r7ucOUV9QWUlMklzqtoREtxKyhT4LPsdL4859q4qA?=
 =?us-ascii?Q?O7GbzOmFyMpxbH92OP2n4Bw6ju//+wGDGc3NwX7kjR3k2AN7yWEAtCJniLZd?=
 =?us-ascii?Q?JOIuzh5+ToLp73XF4JetdSk/AB9UjjKWxL+ykBzWP08lqQBNZkIO60INxZlh?=
 =?us-ascii?Q?K6wIrsZZMa/4j3bZxGj2TCtBCEbyjLdYjEmeXO9Te7nU/9gd7xv9Gixt7Q/c?=
 =?us-ascii?Q?UA1wi+DgnGJarLpvhJdY81R3AWmHCGKvu3vc6YsIoGMGJvmYgj2n0/z83Ov9?=
 =?us-ascii?Q?pJCplrdKUCMYWbpi1NxwyTqUodiWB6uiyPSTetejxE/S0oNDYIXsTgesEZdA?=
 =?us-ascii?Q?9768DfZzit4GNdXSH8s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ded2ff47-afd7-40e0-f4c5-08dc0e1ed7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 18:48:00.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33zbnrSlCJjRBtABhMVotGaQ0hlV9kOm6DMuSUo2UmYlMGwkCX2RxVPF3hO/gScR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

> -----Original Message-----
> From: Peter Korsgaard <peter@korsgaard.com>
> Sent: Friday, January 5, 2024 4:30 PM
> To: Vinod Koul <vkoul@kernel.org>; dmaengine@vger.kernel.org
> Cc: Michal Simek <michal.simek@amd.com>; Peter Korsgaard
> <peter@korsgaard.com>
> Subject: [PATCH] dmaengine: xilinx_dma: check for invalid vdma interleave=
d
> parameters
>=20
> The VDMA HSIZE register (corresponding to sgl[0].size) is only 16bit wide=
 /
> the VSIZE register (corresponding to numf) is only 13bit wide, so reject
> requests not fitting within that rather than silently transferring too li=
ttle data.
>=20
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c index e40696f6f864..5eb51ae93e89
> 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -112,7 +112,9 @@
>=20
>  /* Register Direct Mode Registers */
>  #define XILINX_DMA_REG_VSIZE			0x0000
> +#define XILINX_DMA_VSIZE_MASK			GENMASK(12, 0)
>  #define XILINX_DMA_REG_HSIZE			0x0004
> +#define XILINX_DMA_HSIZE_MASK			GENMASK(15, 0)
>=20
>  #define XILINX_DMA_REG_FRMDLY_STRIDE		0x0008
>  #define XILINX_DMA_FRMDLY_STRIDE_FRMDLY_SHIFT	24
> @@ -2050,6 +2052,10 @@ xilinx_vdma_dma_prep_interleaved(struct
> dma_chan *dchan,
>  	if (!xt->numf || !xt->sgl[0].size)
>  		return NULL;
>=20
> +	if (xt->numf & ~XILINX_DMA_VSIZE_MASK ||
> +	    xt->sgl[0].size & ~XILINX_DMA_HSIZE_MASK)
> +		return NULL;
> +
>  	if (xt->frame_size !=3D 1)
>  		return NULL;
>=20
> --
> 2.39.2


