Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E16610B23
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 09:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJ1HRW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 03:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ1HRU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 03:17:20 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BAD1A9108;
        Fri, 28 Oct 2022 00:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQJbaojrGXwu05Cro1f3ryIDtaT0nYcg9UXKALRuDH9GRLlbULLuppLbX/Xyw8CkUWwtigZEujDL1c6bot/ssJ8qCBEHKfMO9UK4Lx6Xz/tlx5DMWVZYOl67rxBb4MA+ze1ObIIJJZjiu4Q5H6FPOpRkwWlea75647iftG7Y45Db6TRXvuU0sIHBW2CUxHDc1TpDLjLrOWn6XN7u0DyWhwhOE1OtQucWTY9sOVCbgaCoarbJ25nrBLRJKRlI9ab8ljFyx2c4jhmqxQ6wX/xGYuZdTGsk188+Q3HlYeIDkiXVntN+r3WzcxUa9yRO0YNY6gNQhG3GDFyWSh3jGm30og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldxhZUpp/D8wLcAg3yIL/EoLXFIg5RcLLkJCjOcOD8E=;
 b=iCJdTlHvxLPcm+cGZy7mCACXtxfXbAegDtm5QthkYSBJUSTHGFHOPalxlyi/8uKL97L+5p9U77ynSBgJnfpt+8OMqQzvbUMu9Yt8YJtBFLkZ4JHmXpZpPiFh0itcTegfSwHYMTj22zT5CGOI9R5Ut/LKUXTsCxL4DNRqv6jXkdq/UjSkUscamgUgl942Yzq/2V+S+R42SM2XyojZ8Dtd5yuVH1a5W8LHiCbGbSS6aXzacJtfvy0OW0FymNf0XPiNN9m/9iy5+kbQsNZITLnZSNMqQEdyeBghhRrvBxpFHl+4h+Vto0lTm4OK11HwQF39JqTkMdMlFdQhlXFb7y2Scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldxhZUpp/D8wLcAg3yIL/EoLXFIg5RcLLkJCjOcOD8E=;
 b=ZWUoyX2zIrU4dLCioALEjQGhdnv8EIp+ubGMLdDITranXYoRDPIaTzLPUE0/MgfNGYcNdopKtH2yefsiDOR9QaoVLWteay0hCqc1kSzrch3HXtOogKc8XqcFlmtEr2TVcX3ire6uUtIGmJS4vxZ4MkPmUh5v88R/N5wGHIf387o=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 07:17:15 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::4f54:a52f:723c:1d67]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::4f54:a52f:723c:1d67%8]) with mapi id 15.20.5723.033; Fri, 28 Oct 2022
 07:17:15 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     "Gaddam, Sarath Babu Naidu" <sarath.babu.naidu.gaddam@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "adrianml@alumnos.upm.es" <adrianml@alumnos.upm.es>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>,
        "Katakam, Harini" <harini.katakam@amd.com>,
        "Gaddam, Sarath Babu Naidu" <sarath.babu.naidu.gaddam@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 3/5] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to dma client
Thread-Topic: [PATCH 3/5] dmaengine: xilinx_dma: Pass AXI4-Stream control
 words to dma client
Thread-Index: AQHY6ouenB8zPb61WU6H41JY0MiYA64jSE0g
Date:   Fri, 28 Oct 2022 07:17:15 +0000
Message-ID: <MN0PR12MB595316B007EB570013C367EAB7329@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
 <20221028050940.27888-4-sarath.babu.naidu.gaddam@amd.com>
In-Reply-To: <20221028050940.27888-4-sarath.babu.naidu.gaddam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB6444:EE_
x-ms-office365-filtering-correlation-id: a3747310-0280-421e-c3e1-08dab8b470f0
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejSXSJFhEFw3hRdm/RDQxukHSUvpr9zqNzAnVrluuOdZjngrzrM8qlZ1HyZ7tb5znLhBMhEqryJkSb4Qqc9f9LKEg6fQ9LDlywJOel7JL2Bter08U/T1DgvcxFL3X4oosPP+Mcboqe3BJS06Ox3X9hG/rSgsBPFI3ryrdEoWLoQefqr2ghybjxFAYcpPum/lqlvUwUriGaN+veEeVdfuPe0Q/TlMCJdrDm53VlbKWYc8s1yFMoEhlAc/QYcghje2iWdyMYJQxrosqUXoaueU1tEmsAlZ65ZA3Ye0A3ZF1ocjs3xCQQOhu0ae4mKkSOjKLrgSK49HQWF4HF6pprBJ4M6y4sKgPk2c8+OhzYLw75+pNIB4fwEUZFOLo5XkJ4C81tW5eYFHoy+F1XRFdn7mcWQhdpLTP03hEDbHqR3mbz+yiHApkuCs9sz5WTBGNhnS5VTdbBOgfK158gg3ya438Fiw+rKXM5sjc72vJzqOaIMv8UTqosdJvoEAGDDY2Rqh+u7QKGWcDoTfcUppQw/PMxdPZpsK9PfBroKcKr9T8IRAWAmFzzMtj7zWy9HP/GrndpkRR6mIlfq8ZQLIukqeATEsPg1Uj6MvpRHjDczzUj+iKjCqQ703DB3ZXvxihBPtKjD1tWrMjqQfdqjxr7+I+xGoisdEhTqDpLeopfdM5D3nFU31moAAA+0WRZjOPndUnTjj8i6TbjBmnwi1LHKvdNT+SF07DgqLR45c4GwZJ+wMUOWhDna+wUdz51+0rYp0CvcVzVKa1NU226YLVyFDlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(7416002)(55016003)(54906003)(110136005)(52536014)(41300700001)(38070700005)(8936002)(38100700002)(66446008)(8676002)(7696005)(2906002)(86362001)(66556008)(316002)(33656002)(5660300002)(83380400001)(9686003)(66476007)(64756008)(76116006)(122000001)(4326008)(53546011)(66946007)(6506007)(478600001)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2Rya7UJ/68DFLX3qsF3YLkCJ8GiYn0M8e5ZUILLMtXojBkWi6G2kOaDofbS?=
 =?us-ascii?Q?Kmb1Uo8HAZrPA26x2zt5DnKWxJAJCP0IwIsDNbBXHAnpcUIfION28v+Ii0Xc?=
 =?us-ascii?Q?XNaA0AkuNGTBffmh7or4PP6CJ5Coap00EZAHM/WxJeUsEInW8C0k7Q0JbKjK?=
 =?us-ascii?Q?KAEjYCkFOe54+QhUCWg4Cb8K0xJgQ4m4TLgd8NvZ/pok8LOQeZki0do0bDr2?=
 =?us-ascii?Q?fpO3D+14vZFjvZ0lufesw4PFznCIk0wQCAIpM9tVugZPTysykSpiTzaZsEnU?=
 =?us-ascii?Q?vSlkrPKFFY805xuWLK9Fj6g25W1TXHwzbkeAxiCk+uXH4jBYmpLkqYpba/2e?=
 =?us-ascii?Q?bhz+/S2tLWwtMOsPJ+Y35PC37v+0WwOelrpnv2TvTpZkwVh5ZXPuT98lHOpG?=
 =?us-ascii?Q?AdXUc4FaBXsZCVEDeEGD4azdwlrYL/Bhi/Y80vhoaXirC6htuLgrs57Rcjcb?=
 =?us-ascii?Q?dxIwxNa/qjhu6oQKtM8rzi3y1nA6n0Ejzx31cMs1SFhm7Ed5MC2AcaHtZRmo?=
 =?us-ascii?Q?QTp3sL1IZ8jiZ4p20QoGfiFAlNHhPmio48GGv7QW78VSzGg+B86FnRwLpeTv?=
 =?us-ascii?Q?Z9Ao0DDEcLLV/apGpY9fSOiApqTyrcnzJMGjNboY25MQjFRMnjw8oIEMktov?=
 =?us-ascii?Q?iWdJdDXXYRBDePNhg3nvZveFJaZlWtHxAi7b5Q+mlKToZhGyAQLiRTa3zYIf?=
 =?us-ascii?Q?FzJJCbO/C52ZMKxlzDAn5mrajT8JDsciHAxO/U8bIwhBx8LB5ar+lZOzOMaL?=
 =?us-ascii?Q?4RwNBui5JiQfq3FRSKhnXlDsADExMgNGWxDstuvlhjN311hUg7DG3s1vt1c9?=
 =?us-ascii?Q?JF8EaYfdInJfO/E7wscVTx4KyY3QGyx+6kNg7vg3JMAjCA7IQWmlxDgRPpz5?=
 =?us-ascii?Q?6mJC46p0zjfa+Wz7Be4SYzIkl/rBVtWbESdgzssBVUBXK32Y+PYPYQghmKzN?=
 =?us-ascii?Q?YTDimZXFl+LjVlh5M73G19j+m9vs2i9Cv/vlXNtDPFmLEhRDFeQm7MOAQVH9?=
 =?us-ascii?Q?PbFFfaAa0++avgTz3A1h4hGsEOvlE36Hr+tWRl/m2NUUc+PUisn4ndzpjzxi?=
 =?us-ascii?Q?uxTFJ1l6Nau4gb8hKz/EL0qCbxm2+4+o6C7eIh6V6NacaUmRjBn7KmPRCsh/?=
 =?us-ascii?Q?WCGS6y1+yIiCVeAqk/xrv+5DykpYSmoy9u3y9HqegN1RsqFTj1Eo4TbYsiAd?=
 =?us-ascii?Q?qkB8M6lKcOqNJfD/RcIBZZpMMyJSpJWHwfJLySSRqt771H0vCBCWHqppKpUM?=
 =?us-ascii?Q?/gfycye0EXDIOXnqWEHg7Dz9JWt5cWXP8NT0/aRdS1erlvjTNOfsT3dDBY+G?=
 =?us-ascii?Q?tETdai+om2nlL7AB58uENV1JTg/PgTda7s8/0bJ1m/DPBZ5CDZeyS0AsZ8rr?=
 =?us-ascii?Q?5vjHfDsWqoOaaMxJXqrgmQLz8wWZ27EUNvzlTfvkJaTLWNsXd63O9cZzvXzI?=
 =?us-ascii?Q?Um7eCz+cFBqUkfChd/rSh5Tox2Q+ITvU5yyP250R+6Xwvy9xsdGNvePDW2Y0?=
 =?us-ascii?Q?lg4gdMAsAd01nnooQ3nyrqyk4K11lTmYqlq9YrF1Bg2NfT6vA/CvCrB03bVW?=
 =?us-ascii?Q?zi4S6RPMUFw5t2Ygu40dhH/vKSz2f1a8RnkPUUe5YMEKXsYqj8noOmxY0xf0?=
 =?us-ascii?Q?xeLqFQjhc8T8zm//muvvSBN38rH7Kv2YK9Q8oyPWqL+9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3747310-0280-421e-c3e1-08dab8b470f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 07:17:15.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KGbaJXUY/QU/r0p6VjzdoB2CRV/UoLLSxmiWXYDYyW042FRO4AgTZ7bq1MA5/Zz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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
> From: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> Sent: Friday, October 28, 2022 10:40 AM
> To: vkoul@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; lars@metafoo.de;
> adrianml@alumnos.upm.es
> Cc: dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Sarangi, Anirudha
> <anirudha.sarangi@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>; Gaddam, Sarath Babu Naidu
> <sarath.babu.naidu.gaddam@amd.com>; git (AMD-Xilinx) <git@amd.com>
> Subject: [PATCH 3/5] dmaengine: xilinx_dma: Pass AXI4-Stream control
> words to dma client
>=20
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>=20
> Read DT property to check if AXI DMA is connected to streaming IP i.e
> axiethernet. If connected pass AXI4-Stream control words to dma client us=
ing
> metadata_ops dmaengine API.
>=20
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Sarath Babu Naidu Gaddam
> <sarath.babu.naidu.gaddam@amd.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 37
> +++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c index 8cd4e69dc7b4..b69e0482a50f
> 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -493,6 +493,7 @@ struct xilinx_dma_config {
>   * @s2mm_chan_id: DMA s2mm channel identifier
>   * @mm2s_chan_id: DMA mm2s channel identifier
>   * @max_buffer_len: Max buffer length
> + * @has_axistream_connected: AXI DMA connected to AXI Stream IP
>   */
>  struct xilinx_dma_device {
>  	void __iomem *regs;
> @@ -511,6 +512,7 @@ struct xilinx_dma_device {
>  	u32 s2mm_chan_id;
>  	u32 mm2s_chan_id;
>  	u32 max_buffer_len;
> +	bool has_axistream_connected;
>  };
>=20
>  /* Macros */
> @@ -623,6 +625,29 @@ static inline void xilinx_aximcdma_buf(struct
> xilinx_dma_chan *chan,
>  	}
>  }
>=20
> +/**
> + * xilinx_dma_get_metadata_ptr- Populate metadata pointer and payload
> +length
> + * @tx: async transaction descriptor
> + * @payload_len: metadata payload length
> + * @max_len: metadata max length
> + * Return: The app field pointer.
> + */
> +static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor
> *tx,
> +					 size_t *payload_len, size_t
> *max_len) {
> +	struct xilinx_dma_tx_descriptor *desc =3D to_dma_tx_descriptor(tx);
> +	struct xilinx_axidma_tx_segment *seg;
> +
> +	*max_len =3D *payload_len =3D sizeof(u32) *
> XILINX_DMA_NUM_APP_WORDS;
> +	seg =3D list_first_entry(&desc->segments,
> +			       struct xilinx_axidma_tx_segment, node);
> +	return seg->hw.app;
> +}
> +
> +static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops =3D {
> +	.get_ptr =3D xilinx_dma_get_metadata_ptr, };
> +
>  /* ---------------------------------------------------------------------=
--------
>   * Descriptors and segments alloc and free
>   */
> @@ -2326,6 +2351,9 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_dma_cyclic(
>  		segment->hw.control |=3D XILINX_DMA_BD_EOP;
>  	}
>=20
> +	if (chan->xdev->has_axistream_connected)
> +		desc->async_tx.metadata_ops =3D &xilinx_dma_metadata_ops;
> +
>  	return &desc->async_tx;
>=20
>  error:
> @@ -3065,6 +3093,11 @@ static int xilinx_dma_probe(struct
> platform_device *pdev)
>  		}
>  	}
>=20
> +	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {

xlnx,axistream-connected is an optional property for both AXIDMA and
MCDMA. Please extend its implementation for the MCDMA support.


> +		xdev->has_axistream_connected =3D
> +			of_property_read_bool(node, "xlnx,axistream-
> connected");
> +	}
> +
>  	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA) {
>  		err =3D of_property_read_u32(node, "xlnx,num-fstores",
>  					   &num_frames);
> @@ -3090,6 +3123,10 @@ static int xilinx_dma_probe(struct
> platform_device *pdev)
>  	else
>  		xdev->ext_addr =3D false;
>=20
> +	/* Set metadata mode */
> +	if (xdev->has_axistream_connected)
> +		xdev->common.desc_metadata_modes =3D
> DESC_METADATA_ENGINE;
> +
>  	/* Set the dma mask bits */
>  	err =3D dma_set_mask_and_coherent(xdev->dev,
> DMA_BIT_MASK(addr_width));
>  	if (err < 0) {
> --
> 2.25.1

