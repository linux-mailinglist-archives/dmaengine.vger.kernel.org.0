Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67023687679
	for <lists+dmaengine@lfdr.de>; Thu,  2 Feb 2023 08:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBBHjS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Feb 2023 02:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBBHjR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Feb 2023 02:39:17 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FAA6F22A;
        Wed,  1 Feb 2023 23:39:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYW318uCT/8jcPCqAqzQmHo6q3vx+yn4/yC+58IqilTOXiPtjO4DI8Zt/5UTG8eS7+4Sw8XpePxFiyz5mRK1fRIEt4fNEaqw/27j0+pTPyovvtoAFYmy5rLkl6bOioL1rqE39N6Kxb2heZf2b7MH7tw6E0qJ3da5IKo9NwI8qn25iVvSmB7SFlH/Vbl+Emfsy4vIMNMjzRfbc+peKm4aISWKBkafx6pX7b7EIVbanwJnKq1+6S0yN9LNSKboQEMRpRWonKZatWhHaT4F9zAmfq4mF7x1TTCfuQml8TZy+0dbcy9dHPEJHtGfTMONViQ71v7fgdgNakwuLyg7wqfQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D3QjEPlpOrivUL5c7dGrVpnneBzN8A8hqSottti8e8=;
 b=gMIyAri+PQf4qzacAqEKdqiU18hd/g6Ny+WGJUBV4tzuewRFhl/E7WpWZxElZWTa8lQ6+DzkphRBxuWfZl8F/WhSG4t94Op4rhyge5fqj0fVTajAo5yRMFKs73tH0YUXSBfgE3FUf2Dc+tl3dqcSElVM4DdHTi/fVeHblmwoYWTrDT1qlnM+0io5c7Dp3I7qpiAuK4tzD7aStUiZus3ZfpNCNeDvuVflKEx/NxP/QQX6yoSLO9U7PnHep6vKMW3JzkHlHCExMCuhqOMsrc+82dILy8xPz4nIiSQ3ISCyq7W8PHJxzKsUNUTt3Hnn0PkVZ4NTwngr4iLgzfRv5gK2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D3QjEPlpOrivUL5c7dGrVpnneBzN8A8hqSottti8e8=;
 b=rCRsrTaMAbVXI4RG1y3QXTO1Q/BNL82hAAvYhJbgHPJX+J5c2TbJ+xXa3n/VdXyxeB4TURZw4AeMQSL05g3QB1lpfrsciSItLvwrn7N67b4wg4rrp5aFYw1cqmQwwa3rSoPx7zl29dXmBnxxMMxHti0gohH4z+Jt+h7P/ucNjN0=
Received: from MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:39:14 +0000
Received: from MW5PR12MB5598.namprd12.prod.outlook.com
 ([fe80::8585:d686:cae0:4a10]) by MW5PR12MB5598.namprd12.prod.outlook.com
 ([fe80::8585:d686:cae0:4a10%4]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 07:39:14 +0000
From:   "Gaddam, Sarath Babu Naidu" <sarath.babu.naidu.gaddam@amd.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "adrianml@alumnos.upm.es" <adrianml@alumnos.upm.es>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>,
        "Katakam, Harini" <harini.katakam@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH V2 3/6] dmaengine: xilinx_dma: Pass AXI4-Stream control
 words to dma client
Thread-Topic: [PATCH V2 3/6] dmaengine: xilinx_dma: Pass AXI4-Stream control
 words to dma client
Thread-Index: AQHY/++qo3SMgWHWmESnh+GAFjvf166DV0kAgDhaN+A=
Date:   Thu, 2 Feb 2023 07:39:13 +0000
Message-ID: <MW5PR12MB5598DFF156682670F0A8038B87D69@MW5PR12MB5598.namprd12.prod.outlook.com>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
 <20221124102745.2620370-4-sarath.babu.naidu.gaddam@amd.com>
 <Y6whxpN7bgjU7ZvL@matsya>
In-Reply-To: <Y6whxpN7bgjU7ZvL@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5598:EE_|MW5PR12MB5682:EE_
x-ms-office365-filtering-correlation-id: 1f04669e-a0c1-47f5-1d23-08db04f094ec
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jx4cmjjGNKZgYTZo3yiUhExCLPAu5eg0Lc57w52g7TrfBtUY0FfDPjzQiQ7ja0BZ4kxn3R43RICUhpfysGomflOY+Cjk6u5h7sUDCVFgC6PtD8oLOI7tI17/zNYhkkZIER2B/yXUi8FPMpF3Bg8Hv+Q/cNpxFoOAim6VPqCrSI2hRSAz2HEk5/9wgdx+nmoBp4NeEuLFpeg0zpOeF/0Xn5B7SpB1R9bRoA65OBtW16kQHUX0nHsJ3SgW3IwgWF6mLWlwbzCCZ4WaTlcqs2eyOYT7RUirW/evKGjU7NQ6EDEuDUauOBe5eADDOSzGaHLGJ0sN68XqUNBjL8q/1nWzCclHQcxB4/mWLDKcBQ92Yf4Ebay9E0SEQ0juMGGWABEETe58nVso+FO2LHdjP5HZ8eWGn3nc9yKELP6VsXmYqSMDc4z0Z8vxtshIei6XWJPoC5EiHOCbt0rlh9u/kL323rpIc71w48NuPrQwGlnQQR19v+HIpwbj4YY9F1JV/DpPXZn2NvLMOok68rIHwN7P+9N4PB6DR58rJTjrqyeLfASnLf00xSBknolQ/OT7p+avaJr1cT9TH9ENGckGh0eigjRXI5qlSWJnOh2g7iZeNvcdAEZyAWxSIykMqOj7XILWQ7LUsKLjFhecRPpRQXxscrSEPnzD0JQcEAWFXJrTSpixIZevuoXzH9Uxu51CBF/055em/3Xdk8UW5ObEQ9vxxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR12MB5598.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199018)(55016003)(38070700005)(122000001)(38100700002)(7696005)(8676002)(2906002)(4326008)(54906003)(316002)(7416002)(76116006)(71200400001)(86362001)(5660300002)(8936002)(41300700001)(66946007)(52536014)(6506007)(53546011)(26005)(186003)(33656002)(66446008)(64756008)(66556008)(66476007)(478600001)(9686003)(6916009)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QI6nUpHr/X1c2w2UPZNs0C1CeT+CwqW6y1FPFR04T8+9d3lGdhRM4k4kLiEa?=
 =?us-ascii?Q?izXHBcLX2Q6O7/iD5jv4aE422e14Mxq7cknPgiVvDNkdXBRCvzLpjX0NXnwO?=
 =?us-ascii?Q?c++vtiTXFUHAOID/6Y6cgcoIzvtbRDZrUEKQilig6WylUreAFnLAbP0N1Ztl?=
 =?us-ascii?Q?7kqeoXRmb7ChV2euNmXkdrn4Mz4Ym9oRWM/oAqNOmuR/Yc1TLt+XcZTMQ6Lf?=
 =?us-ascii?Q?9kvm6d/0lBICJKiTR1Jc3pwN9Nl0sV1a0f219LGUN7J9AtvQUpExJQbuq/nD?=
 =?us-ascii?Q?KSPj+oWuADhJbwskBW8DNSkxtsAqI6P1kqowlS5bEy/stjUFe2xKGZomwe7u?=
 =?us-ascii?Q?SXmuii3Sjc4LFyfVrtRmQ8lvTPJgZeTa4PDqn5JxqPvuitRSskwU/e/9CWs5?=
 =?us-ascii?Q?1/af1exJTapllSC+zBIK+jwOgpYCzI4WXkmqfmBqtIIzhHBtCRf5vrUmI+wj?=
 =?us-ascii?Q?2ceXMQAUQsOnLD61exay1OYcaHY9bcHXeI/2ZUql16L0yfJlLMmSxF1DAEpv?=
 =?us-ascii?Q?yJeI/l0Ay4bNn8M1PidbXhuJByx2riw5DDSkmxxDqBnYIFh1AEMU1WOgu1ZI?=
 =?us-ascii?Q?KGmI1VAtYYXgpvaxS6K4jQheAcvq7y5eYtHFB+RVGMJiEOn0PVDNa7RDmT5n?=
 =?us-ascii?Q?NFtp5uDTTtTQpxOyADkwAEL2yC7MOt27AtcCBwAUN4hmToDhxpxTP/jX515x?=
 =?us-ascii?Q?/EyaPHuHr56fOd5zKMGfF72yXPtjbQImdfrxEY9nS8ameYFzRwRlSrkn+y9n?=
 =?us-ascii?Q?qdbVE4oQYOuPsSYmpc+KoLLEbtiAZTze1S9AN28/PteRAQ7YsICfLnK0S1xT?=
 =?us-ascii?Q?InYdzcRPA3lUpPusLVtK+SHieKxpShe3D1KhKHECsxZ9pCkIyYOIpF9S9uF8?=
 =?us-ascii?Q?yCIFOSCa2nAwhmgnc9uxQunsb/Ez8r8ji7lmODgk7tzv5tAfcQ1M+iOFP4bO?=
 =?us-ascii?Q?LABHNkHxuyALPXTxNtu2lKVxxgfgiuGlj1bKv1hxqLqRYkE0sWrGpeHGXfRm?=
 =?us-ascii?Q?IbriMfk7yjKD9y5Q7HnYLZQmFmblXSjO5z/mkNd5ptIlV0hEBiQ7JK/2pyY2?=
 =?us-ascii?Q?0rbcMKYT3Z5r1h/MGoEfAzyOWTjJHk01OYu8ghZAF0Y/mTlHj0VENoRPsUtK?=
 =?us-ascii?Q?4jQW12ZGMu7VL63x4H5Y/MW3fJmxw+rN741GzzZPe7qSl8g8q1ULCSax3o5d?=
 =?us-ascii?Q?E5lcph+0WNrdoBImwBGdLTPJqEl0KfyymzEaPSmNMkim1L5kMSpU6ykG3AOB?=
 =?us-ascii?Q?/FucQKH6Qf7pRUcV8ICuGu57d4pheMDLg8VwpBug+YAoPz/F9F1teR6nKMHH?=
 =?us-ascii?Q?Xk0cy6XrplQnKyIggPVm1seRGFU9SEgGlu3hIwPBpVvtfwDkJp1iC3WRDmwy?=
 =?us-ascii?Q?ON8fxrjItXjuaIFPzaYv6K61CvLBK9JvtwFShVkRensMFcBt4h41evhx50iM?=
 =?us-ascii?Q?N+UZ5UTcbf06gVZrbAIr3SGj4mWBmFIJ+84waC/qBW6KjqDZMg3o3+66FrDj?=
 =?us-ascii?Q?igTlZOvbEZzD2uEvW+ppxd6cRJxJuNgFFSuKyATz4Hp12EU1LXK9czYv/WOJ?=
 =?us-ascii?Q?b26CVFU26GFdljKKejA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f04669e-a0c1-47f5-1d23-08db04f094ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 07:39:13.9752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuFvosvd17Etk8Yd1wNmU1X6cQwUmhhkf/Ah8wF+XuYsF7qmws3OnhH0oK+My+lR3oomye8/A0FPMxrDaqWB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, December 28, 2022 4:30 PM
> To: Gaddam, Sarath Babu Naidu
> <sarath.babu.naidu.gaddam@amd.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> lars@metafoo.de; adrianml@alumnos.upm.es;
> dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Sarangi, Anirudha
> <anirudha.sarangi@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH V2 3/6] dmaengine: xilinx_dma: Pass AXI4-Stream
> control words to dma client
>=20
> On 24-11-22, 15:57, Sarath Babu Naidu Gaddam wrote:
> > From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> >
> > Read DT property to check if AXI DMA is connected to streaming IP i.e
> > axiethernet. If connected pass AXI4-Stream control words to dma client
> > using metadata_ops dmaengine API.
> >
> > Signed-off-by: Radhey Shyam Pandey
> <radhey.shyam.pandey@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 37
> > +++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index 8cd4e69dc7b4..f783ba86cb09
> > 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -493,6 +493,7 @@ struct xilinx_dma_config {
> >   * @s2mm_chan_id: DMA s2mm channel identifier
> >   * @mm2s_chan_id: DMA mm2s channel identifier
> >   * @max_buffer_len: Max buffer length
> > + * @has_axistream_connected: AXI DMA connected to AXI Stream IP
> >   */
> >  struct xilinx_dma_device {
> >  	void __iomem *regs;
> > @@ -511,6 +512,7 @@ struct xilinx_dma_device {
> >  	u32 s2mm_chan_id;
> >  	u32 mm2s_chan_id;
> >  	u32 max_buffer_len;
> > +	bool has_axistream_connected;
> >  };
> >
> >  /* Macros */
> > @@ -623,6 +625,29 @@ static inline void xilinx_aximcdma_buf(struct
> xilinx_dma_chan *chan,
> >  	}
> >  }
> >
> > +/**
> > + * xilinx_dma_get_metadata_ptr- Populate metadata pointer and
> payload
> > +length
> > + * @tx: async transaction descriptor
> > + * @payload_len: metadata payload length
> > + * @max_len: metadata max length
> > + * Return: The app field pointer.
> > + */
> > +static void *xilinx_dma_get_metadata_ptr(struct
> dma_async_tx_descriptor *tx,
> > +					 size_t *payload_len, size_t
> *max_len) {
> > +	struct xilinx_dma_tx_descriptor *desc =3D
> to_dma_tx_descriptor(tx);
> > +	struct xilinx_axidma_tx_segment *seg;
> > +
> > +	*max_len =3D *payload_len =3D sizeof(u32) *
> XILINX_DMA_NUM_APP_WORDS;
> > +	seg =3D list_first_entry(&desc->segments,
> > +			       struct xilinx_axidma_tx_segment, node);
> > +	return seg->hw.app;
> > +}
> > +
> > +static struct dma_descriptor_metadata_ops
> xilinx_dma_metadata_ops =3D {
> > +	.get_ptr =3D xilinx_dma_get_metadata_ptr, };
> > +
> >  /* -------------------------------------------------------------------=
----------
> >   * Descriptors and segments alloc and free
> >   */
> > @@ -2219,6 +2244,9 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_slave_sg(
> >  		segment->hw.control |=3D XILINX_DMA_BD_EOP;
> >  	}
> >
> > +	if (chan->xdev->has_axistream_connected)
> > +		desc->async_tx.metadata_ops =3D
> &xilinx_dma_metadata_ops;
>=20
> This is an optional property which is added now, what will happen if you
> are on a system with older DT? This wont work there..

Sorry, we missed this comment. If this optional property is not there,=20
then driver does not export "metadata_ops" APIs and it does not=20
break any existing functionality.=20

Thanks,
Sarath

>=20
> > +
> >  	return &desc->async_tx;
> >
> >  error:
> > @@ -3065,6 +3093,11 @@ static int xilinx_dma_probe(struct
> platform_device *pdev)
> >  		}
> >  	}
> >
> > +	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
> > +		xdev->has_axistream_connected =3D
> > +			of_property_read_bool(node, "xlnx,axistream-
> connected");
> > +	}
> > +
> >  	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA) {
> >  		err =3D of_property_read_u32(node, "xlnx,num-fstores",
> >  					   &num_frames);
> > @@ -3090,6 +3123,10 @@ static int xilinx_dma_probe(struct
> platform_device *pdev)
> >  	else
> >  		xdev->ext_addr =3D false;
> >
> > +	/* Set metadata mode */
> > +	if (xdev->has_axistream_connected)
> > +		xdev->common.desc_metadata_modes =3D
> DESC_METADATA_ENGINE;
> > +
> >  	/* Set the dma mask bits */
> >  	err =3D dma_set_mask_and_coherent(xdev->dev,
> DMA_BIT_MASK(addr_width));
> >  	if (err < 0) {
> > --
> > 2.25.1
>=20
> --
> ~Vinod
