Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D8E57CD81
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 16:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiGUOX5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiGUOXc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 10:23:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED80F82FAF;
        Thu, 21 Jul 2022 07:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw/FskE0EE4gbl7iJr1fIfu+1qInrWFXD0rf4Ob3bNhtWbLfF/y1glO0U8i/WlxHvjc3Wl86VQhxnojjSHHELiXxbyRYqldP9BXZW7Je9hhZKMaPh/3SMunF41le2kUqu2HWk2yoVYAJNDVaL96jAs5KQxqGJHh4mYRswYYVuKgVnhkps1NYRhoAXTVPSPpkmxqAr6g3CzAgBTsB+6zLP9KdwiIVff8rfguIt/ap/oKdGp4mhmihiHPV3jxmYZ0amtEG/WNcXDDYwjX6OSOXHJiR7K0cljXyT7wDdWLhUkjuLaWsm0sJ3u/W4Bn6nCem4VtDbPfRmX6vIfegAgtovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BAJI+fThghWzNS4XNtYONLWfQMivUcOdRweQYH6MmA=;
 b=M/AVGxCQbzxhywK69dzJmLO+isYXkDwhjhKuxoS5kznwiCB2UHQgYauNytuC0PMBhcbJLptM3IkeuG9UbUS6b17PQcS9aJhTpSlkoVkOL7Si1+YZN+q8L1+i9Ys5t9/IPEv+p2fYYZuf4GfqA65Qq2pMi1m0i62xgmxkA8Icf13r6G3lGaAivQl5z+TtWx4KSNBDbKvm8F0qZnv+J6W4G8mXsxZDTKN8UVT3IzGJdNY3cIfWFU76dZo9NZ1Bk04LEv3oXf52XBEBlg6pFhLTlFgR8cbMVc4iH94h4i5AKtrKYTe//GOL+YlUGu3t4pPbk18DeZbl0Ck03lV1zmZVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BAJI+fThghWzNS4XNtYONLWfQMivUcOdRweQYH6MmA=;
 b=iQZbI+mGgVNpC8ImayU8cXOQle7gCQFRrpZxLfSwxTVxB4nAqQddDnY43VVKy5UYo/FpDpE15Zs1p3gW6xdqh2c2zIYmiWgl8a0VFzd1MKrvN09Tw9JpycJmAFYYCUJrYUtJrWDexDdUdYXhROTE/8ubFRuPLiLicNO8WLWohN4=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:23:12 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::bd1b:8f4b:a587:65e4]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::bd1b:8f4b:a587:65e4%3]) with mapi id 15.20.5438.014; Thu, 21 Jul 2022
 14:23:12 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "m.tretter@pengutronix.de" <m.tretter@pengutronix.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        Shravya Kumbham <shravyak@xlnx.xilinx.com>,
        "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH] dmaengine: zynqmp_dma: Typecast with enum to fix the
 coverity warning
Thread-Topic: [PATCH] dmaengine: zynqmp_dma: Typecast with enum to fix the
 coverity warning
Thread-Index: AQHYb0LkOX4+245pnEK0Y6LTVu67+a2JO/jQ
Date:   Thu, 21 Jul 2022 14:23:12 +0000
Message-ID: <MN0PR12MB59533B9E84A41900892E13D7B7919@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1653378553-28548-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1653378553-28548-1-git-send-email-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15abf2b6-24cb-48f4-5e14-08da6b248b69
x-ms-traffictypediagnostic: LV2PR12MB5848:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7r6eqYXEnJNsZ+FPsvskKaBtozx2bQ/jadIxe52IxU1uoA1fDamOR3j3fILZHeTu1LAH69o37B3sz305pdvI1c8GMwFrvKWyfWxLTpHa9fV3E9AXEfXIBuuCSIoHEOdx6EJslj+CVroLe2Fk2w2JWJSYsoSuDkralSRLTjRlT2RR2otwOd5962BEOFu5D/cHfdAOsfygbM8XoAT2pEM6eC2iV4bOWxdEymSfdFu95CV3H+ME/MM06hOYg1B5dtg8ew685ofqUVi75ClgphYbSx4EtQfAdqaL2ydDsBiXWimhXmkgp4auvoPriN2wAqphzV1GlsFlCe8EFzVGo6REE9TKf9BPGIYnaR33w9gPKaKMpITj8j8TSeF2oKZsgS5XgBATfUr6+WTguaplztd/Mb+1UjZPaBrTsT4BB2u1e6KcSAFRkKRogu/rFKm1FSN6U8geFpeqPBzCjbjqJBdQljYyZQblHZOpySkA4xhwWQf/2VmsFJZ+2zmIQoLodzAiwwjnsStaPhUhMTYTKVsWhRL85jFu0ZElkFMI/nkHoMDmZaZebArjzBn+OguNRI2hwSSqPJ6K5/NF7XhYetoiFrq+5Sun9bpKBYtyR/CQswNZlpHRQyirAMX7suLU71DV+glHx8Y42w9eenms2Ml3z0MrwZo4rdvZghRE+u9J5Rh1Jnbnhs9AULcMUWuANkm0u7YM03Kiao+6RFh5AwUgpfj/Z2HXt+gPgTvbbD7oEBfmGX6d4JUzmQtkYHFWmJjp/yB2ypmMKikwsiGi7geHy/I2tUoUXL/VZNyUkYHcmUrUMw4dewzVSmDNtZ5zBFE646A1h2bSiZtQ92iejBZRpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(38070700005)(53546011)(6506007)(38100700002)(7696005)(86362001)(52536014)(8936002)(41300700001)(966005)(71200400001)(122000001)(5660300002)(478600001)(4326008)(66556008)(76116006)(8676002)(9686003)(66446008)(83380400001)(54906003)(110136005)(316002)(66946007)(64756008)(33656002)(66476007)(2906002)(186003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xu13HOJTQNxKJbU5tvGFW9Aw+mxEKfif8BCskatY6dm8b6aSyFLcKftN48JK?=
 =?us-ascii?Q?OLl8T1ombaU5YHiz8Oy1Q2ChuDO8I8Y2UiJ2JlBhpTzuOlmR2xD7ka2j8Ziy?=
 =?us-ascii?Q?oWa6IagbzFhEUa9YYuCN+kwAHroOM6tt6iJtNjulTyFw7PBlZ1joQYHFxnC8?=
 =?us-ascii?Q?gylOeuLjsTPCjwESa2kLHbwog0J7gO6JivmnJaazPOG86Z13QOgxwAIERhPm?=
 =?us-ascii?Q?MZqOAp9JCZkiR0EtPR3yLHrkgg83QOQd9hRzQRV4sKwjqLyjS14k5bJcza6Q?=
 =?us-ascii?Q?NUmLzG8oaYUs9JudJ4d17YAyxwNJUX+wPcq6nGDMSlKEc2mRVz8OM1+WXglf?=
 =?us-ascii?Q?PlMUDCAY0t9DIY9ejcNwvZaq5V8267M8KqjMt7V9sMQNktBNW0PKRvo4Di0P?=
 =?us-ascii?Q?NyTqP22BYhAkSctb8W00fXza38v6Ffwrp4uC5GRGbB+Mur2HpV25lvKXT8Zl?=
 =?us-ascii?Q?wTTYjMAaDfAAFAh3DZBQYCaCLTg8S5JSJhJhdQK2oI0Izth7FiBuXELXruTy?=
 =?us-ascii?Q?TpHjlNmyn6oXBTTajgfSVSlSV+Pw11Zp5ID3uDFGXPYgKnozsxRLUBDnii/X?=
 =?us-ascii?Q?h83JQvwNrWeTkqL8cp5nzMaC4smHE0EBUeqpkY1QLJUREq5E//+pz6HZejkt?=
 =?us-ascii?Q?0pQh9Ner/ndF5CYsNhEt6BM1kXhMP99BXsTADgzTynLrJcC6Fg2yElJ2N4m0?=
 =?us-ascii?Q?dkH+YegFZVTnJBVi1kb8pRVt3AsvMrH4K50N4+KUp04mlTvCPJUSXSeSHH+v?=
 =?us-ascii?Q?4o1iHJpCPQZBcu53XpT7L97f+A7My02Wb5/LSuyxB/P9lrowASRZrkhio81k?=
 =?us-ascii?Q?/mUARYrRMpsVa99GL9YtBw3fIvaNBIARxmB8s1ZF0sc6ZpDfmLRexePEoMNj?=
 =?us-ascii?Q?mNnlQOnZGOYp89ZkplQMcBQyB7fM8zzsUnff8uo99vjGQiGptUInTc4GsUzN?=
 =?us-ascii?Q?52kc63RkF5cGN7tpdOiNTUdh8sQCf8ReEPzOf38RUD/g+CV62+NR2bCsjH4M?=
 =?us-ascii?Q?KDTYSnBn0djgkCb+2FcVqA94pvf4f/n9drtTEukgZ+s7Z+XIi2Bi0UXDLis2?=
 =?us-ascii?Q?E+xsnYnuC26DsocGDCEFMQJRTqiO6bDQJa1ukHNRhh+PC/C9mPr8hf0Nesnu?=
 =?us-ascii?Q?4LHTSZvETSWvlX8hJG5B4mmHLNTZ0wUk5l1afwkkkqrr4jkKiYLWm4A8TYIw?=
 =?us-ascii?Q?A6nEo8AI8i3Fzca+96dxyrVxA4t9ZuA84LFvq9e7EOJEwt9OzABwpGEJXs//?=
 =?us-ascii?Q?vR5KpjW0VIgtaSUrK4E39Z3Wz4jwgt2jMF3xZJVwSyMkplmoybgTQN7jN+FY?=
 =?us-ascii?Q?2xe+HKIPAkxMXcxO+ILpcfbdWMpwywO6YwcGHVKnOA8TngxIxuw7FmIp7L4D?=
 =?us-ascii?Q?8mvfth7v2dMOG+LDh9OywLJErcRVtbR6H4nJcliRRH+IKehQvakYNxrpFrfX?=
 =?us-ascii?Q?LipEDuUxadQJRfWTAgJtToxjPqw3kLNBCUlyTY+0Iojh6sF/dgM5DJvHS1ft?=
 =?us-ascii?Q?5fhG1NFkCR71hsulbZDhk/vLqIFP6tbjBSDYymIkw+jLPkyfHByCfGGzyjHq?=
 =?us-ascii?Q?AnmgfrVUbu1EUTG10/8WwyrEnQ8PxMrXXqkb+jXkZT2KunTB5D1xIZ+xtcju?=
 =?us-ascii?Q?oVRMSkcfTONDMHBZOrdf4c8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15abf2b6-24cb-48f4-5e14-08da6b248b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 14:23:12.7967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qoz0NZY0AYOCuZDC6FH2kCiNvikqA0BF2YD3NxF73gvJNk/2EPBjCn2ZbVf6jdWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Sent: Tuesday, May 24, 2022 1:19 PM
> To: vkoul@kernel.org; Michal Simek <michals@xilinx.com>;
> m.tretter@pengutronix.de
> Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
> git@amd.com; Shravya Kumbham <shravyak@xlnx.xilinx.com>; Harini
> Katakam <harinik@xilinx.com>; Radhey Shyam Pandey
> <radhey.shyam.pandey@amd.com>
> Subject: [PATCH] dmaengine: zynqmp_dma: Typecast with enum to fix the
> coverity warning
>=20
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
>=20
> Typecast the flags variable with (enum dma_ctrl_flags) in
> zynqmp_dma_prep_memcpy function to fix the coverity warning.
>=20
> Addresses-Coverity: Event mixed_enum_type.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> NOTE- This patch was sent to dmaengine mailing list[1] and
> there was a suggestion from Michael Tretter to change the
> signature of the dmaengine_prep_dma_memcpy() engine to accept
> "enum dma_ctrl_flags flags" instead of "unsigned long flags".
>=20
> All device_prep_dma_* API variants have ulong flags argument.
> So this is a wider question if we want to change these APIs?
> Also there are existing users of these public APIs.
>=20
> [1]: https://lore.kernel.org/linux-arm-kernel/20210914082817.22311-2-
> harini.katakam@xilinx.com/t/#m1d1bc959f500b04fa1470caa31239a95c73fd
> 45d
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c
> b/drivers/dma/xilinx/zynqmp_dma.c
> index dc299ab36818..3f4ee3954384 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -849,7 +849,7 @@ static struct dma_async_tx_descriptor
> *zynqmp_dma_prep_memcpy(
>=20
>  	zynqmp_dma_desc_config_eod(chan, desc);
>  	async_tx_ack(&first->async_tx);
> -	first->async_tx.flags =3D flags;
> +	first->async_tx.flags =3D (enum dma_ctrl_flags)flags;
>  	return &first->async_tx;
>  }
>=20
> --
Ping! for review.
