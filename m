Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5726876C1
	for <lists+dmaengine@lfdr.de>; Thu,  2 Feb 2023 08:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBBHwH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Feb 2023 02:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBBHwG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Feb 2023 02:52:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCED830FB;
        Wed,  1 Feb 2023 23:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVC1XmJM9gk+/XiqByvXbQVAmVuuVseGHi9eQmLFGJxGiGBA2eZENE+Zl0561je90Fq/wtfsGYAXObf1Bu5kxRVwGRdYlsh5Kl6HBoZj+JvMXUkcHjgUZhjVf3y+Sc8hqrS9fLpsUB9nLK5Av53FO7FSnpC83USQoBQlX8hxoAnTJzNyjviCIf9UyY+WL0X//RAaAo5opaqfwFg3vcC5++ZbiBaE4+KmwMbKNYDv7jZ54MSdyUHNMY0nYiYQrqqUXtLhWQLLmNkCAE6eMdE34Qh8tGMd8SRTdU/GFrVfsgqsFiIi6YuGmiIoFkw4Q43gNi81cjh+fmcm6gRZLtvYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWC9gcscFB7MnKqRBP53yaaf4KAk2vzynP4kGd7sIfc=;
 b=FWyOL3UWjF4W5VGepdF6wHV06a/kq1CoxWnjSjkKS/osxkZIhR8oTv4iMLZiBYvQ8PejqRU9hTGofUW5GYxIHZ1+wtVhPVqQXm/YsGp9dcnnxCpdL381lYAN4octF20wQjXijX5Zwmf0UYctew7cniPOh4leocw4o1jxR3PkIuwjncGZeEwLtNWorURW3CvcOoA8HGY4wi8Bja6yWlfVbZByuhISLWDzBKCfAILcEO9htVYo6dNoquXn5UIMEvel69f4eWzJx6x7Nfr7mSEVTfQpt2JW+0U7i7gYAv8KeAZiAFoC0iTPcgvxcdQ9n/ZYpzT0a4fnNZCC43wAxVqhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWC9gcscFB7MnKqRBP53yaaf4KAk2vzynP4kGd7sIfc=;
 b=44ikaHtfg32GMJ0X1WbpXyiJbLe7NApHZMI6Xt/SgKjtdrp4EMtymuAhMxwxCnS37He+4XKWQYWb/ZsKGcUh5HheWsYlGL46/vrNkmrgwdxfOD5f8ooofe8sE77joZk59buj73zruf9su2Xyy+urXDhJixtJ547dBRUAo2u9u2k=
Received: from MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:52:00 +0000
Received: from MW5PR12MB5598.namprd12.prod.outlook.com
 ([fe80::8585:d686:cae0:4a10]) by MW5PR12MB5598.namprd12.prod.outlook.com
 ([fe80::8585:d686:cae0:4a10%4]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 07:52:00 +0000
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
Subject: RE: [PATCH V2 6/6] dmaengine: xilinx_dma: Program interrupt delay
 timeout
Thread-Topic: [PATCH V2 6/6] dmaengine: xilinx_dma: Program interrupt delay
 timeout
Thread-Index: AQHY/++1voKTnTLde0axfE0Yfexfaq6DV2WAgDhcHzA=
Date:   Thu, 2 Feb 2023 07:52:00 +0000
Message-ID: <MW5PR12MB55981EAC28AC5A32BF76CF7C87D69@MW5PR12MB5598.namprd12.prod.outlook.com>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
 <20221124102745.2620370-7-sarath.babu.naidu.gaddam@amd.com>
 <Y6wh3W0S/pzTI4vL@matsya>
In-Reply-To: <Y6wh3W0S/pzTI4vL@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5598:EE_|PH7PR12MB5901:EE_
x-ms-office365-filtering-correlation-id: 6b2166b4-ff4e-46ce-65af-08db04f25db7
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3IpgeVcQaRBX3NPHCN3H+OTtpK78Cz3IwHbQyxsDPEuOHWNbSc+3ArRa1Qx6M3YdJX6ZnW2z7FZlJeCk26PChCxe8RL+QDO7etmRFhG5Dr4FoJbK/bvno2rWgmRHBoXJUUcxiPpDEk+wz9xzoJCcp+LIQeu9TlPVMtX8x9JV2l2KJjnO/CgWrCLAKGzV/aHSANdbKrmRWbNyyt1rHpTAMq2674ti1GS1UV/XWwAtfcwYaq0ojPdesUUs1stnlRrW1OiGRHzW9Spn3t5KVQvzwjYPGfkeRLCL+wTGk3Xotj02sofrKzRIDPWRqi76jFI5eMiIIWyDyQ81Zxv8+DPcUJ3aI83H7e/17yNvqPJLDFT8WEhimiri9wVeMdl6jdyeAtEhAk046KDCE2aa8bPL41DfGWzj4k+qlBBU3h/6uUQI9Bk3z2iWW7hYkzNgF2zY7zCtpt5sAEB9fTDIE+Bci0blhS/ArQEr9yW+/Ibs6MS9p+JfEzr+dKQgXI8kNMsU1DtTFpxRlN5OMy96RtGd+uSoOysGpCMGm4Pqn2AwZr/KcVZvTbgMIXLIQEgub7wnoxPi2qO/c1Eoag99FL9la+WK1Bu/JlBaoTs5egKPdfWNnO3fFiUWLjIh7jOBkVfO7mImQnVL9C2qVhLPZVRar3/xYKGuEepcSOVkFnVyMBOHItNnGNmhwKrRDBNusHxDBUsJWNa3prznbfoJeXnh/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR12MB5598.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(76116006)(66476007)(66946007)(66556008)(38100700002)(4326008)(83380400001)(8676002)(66446008)(64756008)(6916009)(54906003)(122000001)(316002)(6506007)(53546011)(26005)(186003)(9686003)(33656002)(7416002)(478600001)(5660300002)(86362001)(55016003)(41300700001)(38070700005)(71200400001)(7696005)(8936002)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HEZVOwTut+mKENfwROVLWkkZvQ8VCFytAGHtYtMuWvmPEnfil1koIvEir5Pa?=
 =?us-ascii?Q?2YzXnKAqU9buBeX278xafPY9nhDiiOQHZGW67M2FrXDvxgZCkeZQSVSIvB73?=
 =?us-ascii?Q?+xcjPguYzXDwDbFrrJLF/ffJNFfQXGXNAMROo59A0BytJnXbuUgQpFdahXkX?=
 =?us-ascii?Q?yhDkJPZE//qsmeyfxSmHS+GVqyG7mwsFwebo6uopHoac9qNaU59/3DbceY4n?=
 =?us-ascii?Q?Z1inMS60X0k+fcpDPVogp6Kj6qcnURK1YDLT3oJC7hEvAM/xh8lD3X976v3y?=
 =?us-ascii?Q?CGOQJDSEIwOxEyJ/c/JUHHbZcskRaO2qYN0a3b0H4nKATIK/9GlDZL00UAUd?=
 =?us-ascii?Q?j+1qOs2EaaeB3EA5SskWyNZA7M8cRq56rle2Ze/yF6Du9aBHNwdgAtdfBzEs?=
 =?us-ascii?Q?3159b1Zi9MhsiMXY7KFOMdCcliCsp//gLRn0oUHpCaxYrh3Oyli/Mh9dKqbV?=
 =?us-ascii?Q?Vx2rDV5ckuOZXMaYB2xeTn0FzAnw8OSQ9Y2XUNY6eY1oyqUnCQrHPm81p5RN?=
 =?us-ascii?Q?PcukaxCsE/lgEJZBOm5YlzJVN77Rbl2NNt/tERjSsytOuU5OEgMO7hDT1PYD?=
 =?us-ascii?Q?ea9kr3+8TyXwMNCzQTGYNF9oXlZLGEpdUVvJoFPselxKFfBYJiQmxo/3kAk+?=
 =?us-ascii?Q?PjEK8Y3b1PFBrNPkjGNblQvh3TkPAknH1Ge6U5kZGZzGWnnAuUMwAZTkID01?=
 =?us-ascii?Q?vDEfP8ejhV/R/4uHZkFGCRQcVRwe2sfzfSFAFWnus9swjNH2cPA8xmUDgN3T?=
 =?us-ascii?Q?OgnoTZnLcBvK7rJ/cfBCIYc77n3pMd/+QDxgCgFKuK6+UXwJken5iv/2eTeh?=
 =?us-ascii?Q?cvJgzhGXPMsMEOxtxCCpaZrHTLdziPsnx0yX6gxoIhYfAqvSpDWKlHpJefU5?=
 =?us-ascii?Q?dCPXnGpaDWHgv9+s0bvwWOWfAZF4vuNonJfrwADSo+Nj024GFPgwffAJftvS?=
 =?us-ascii?Q?nMKbEEC7hFhmH1XR5ZE2b/S8NdStikxs9rQyO778u3tyxrNpGVBjuW8Xt4fA?=
 =?us-ascii?Q?eXSyWnOSGb7ggnzpPNq8Gn8pT+7TVNNoTQCkO3uyrG7zIKG6lT9GQ01Z27dx?=
 =?us-ascii?Q?OU4L6/Be+XnRZs+H9tq2v3hynK2HvPbBD6tuRIbANw21pc0KGmK1lfKjBVIp?=
 =?us-ascii?Q?zfz3kWxI78d0CD+aYMB9755OazIIjY1seF+cpQzdt+/AQT6qRmVLCIoMLryq?=
 =?us-ascii?Q?LeY04TI8/vJBvkSK7fF93E0cchXonG5wi2KeCoezbeQewWCyeV4IRZ5AVlYU?=
 =?us-ascii?Q?0LD0GIJS7uh71loZAQvwIdnMg/o78w92zo3qr2SAIvg0ekQHH7wwe0ZHeCSP?=
 =?us-ascii?Q?IhdkDlU7vgsXsww+KcFvVE3o+xapOqa7BfB0lAB+DUtjl7t4/mSRgV89t9bQ?=
 =?us-ascii?Q?6i+OCCJ3EM1cxSfZBVYrvWoG86TIJX3+hTIX+I4UK+HJSg3NZdr7Zqz/KtHz?=
 =?us-ascii?Q?K9m4tXBcK9CxnlTrHfpTHaKf8P/QdKdCGiCyqPz0z6VOcnkxFgjDFRT4qe2O?=
 =?us-ascii?Q?VFLCWR+7CDxnLfvofa10rov043I6yoPFAPnP5IFOWKhhte1KXsbxcTc/D/Xe?=
 =?us-ascii?Q?QOJtu0YCaI3tmET49cI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2166b4-ff4e-46ce-65af-08db04f25db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 07:52:00.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVlNIuWsDva0C7ArHph30W3aPpNtweTVJrxxl0udUZzv/QkU8Bkw5UWVq3Ql7JXudX4qbqnQFWWT4FfCNi/Daw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
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
> Sent: Wednesday, December 28, 2022 4:31 PM
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
> Subject: Re: [PATCH V2 6/6] dmaengine: xilinx_dma: Program interrupt
> delay timeout
>=20
> On 24-11-22, 15:57, Sarath Babu Naidu Gaddam wrote:
> > From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> >
> > Program IRQDelay for AXI DMA. The interrupt timeout mechanism
> causes
> > the DMA engine to generate an interrupt after the delay time period
> > has expired. It enables dmaengine to respond in real-time even though
> > interrupt coalescing is configured. It also remove the placeholder for
> > delay interrupt and merge it with frame completion interrupt.
> > Since by default interrupt delay timeout is disabled this feature
> > addition has no functional impact on VDMA and CDMA IP's.
> >
> > Signed-off-by: Radhey Shyam Pandey
> <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Sarath Babu Naidu Gaddam
> > <sarath.babu.naidu.gaddam@amd.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index ce0c151d8f61..333d68ee3559
> > 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -173,8 +173,10 @@
> >  #define XILINX_DMA_MAX_TRANS_LEN_MAX	23
> >  #define XILINX_DMA_V2_MAX_TRANS_LEN_MAX	26
> >  #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
> > +#define XILINX_DMA_CR_DELAY_MAX		GENMASK(31, 24)
> >  #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
> >  #define XILINX_DMA_CR_COALESCE_SHIFT	16
> > +#define XILINX_DMA_CR_DELAY_SHIFT	24
> >  #define XILINX_DMA_BD_SOP		BIT(27)
> >  #define XILINX_DMA_BD_EOP		BIT(26)
> >  #define XILINX_DMA_COALESCE_MAX		255
> > @@ -410,6 +412,7 @@ struct xilinx_dma_tx_descriptor {
> >   * @stop_transfer: Differentiate b/w DMA IP's quiesce
> >   * @tdest: TDEST value for mcdma
> >   * @has_vflip: S2MM vertical flip
> > + * @irq_delay: Interrupt delay timeout
> >   */
> >  struct xilinx_dma_chan {
> >  	struct xilinx_dma_device *xdev;
> > @@ -448,6 +451,7 @@ struct xilinx_dma_chan {
> >  	int (*stop_transfer)(struct xilinx_dma_chan *chan);
> >  	u16 tdest;
> >  	bool has_vflip;
> > +	u8 irq_delay;
> >  };
> >
> >  /**
> > @@ -1560,6 +1564,9 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
> >  	if (chan->has_sg)
> >  		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> >  			     head_desc->async_tx.phys);
> > +	reg  &=3D ~XILINX_DMA_CR_DELAY_MAX;
> > +	reg  |=3D chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
> > +	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
> >
> >  	xilinx_dma_start(chan);
> >
> > @@ -1887,15 +1894,8 @@ static irqreturn_t
> xilinx_dma_irq_handler(int irq, void *data)
> >  		}
> >  	}
> >
> > -	if (status & XILINX_DMA_DMASR_DLY_CNT_IRQ) {
> > -		/*
> > -		 * Device takes too long to do the transfer when user
> requires
> > -		 * responsiveness.
> > -		 */
> > -		dev_dbg(chan->dev, "Inter-packet latency too long\n");
> > -	}
> > -
> > -	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
> > +	if (status & (XILINX_DMA_DMASR_FRM_CNT_IRQ |
> > +		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
> >  		spin_lock(&chan->lock);
> >  		xilinx_dma_complete_descriptor(chan);
> >  		chan->idle =3D true;
> > @@ -2822,6 +2822,8 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
> >  	/* Retrieve the channel properties from the device tree */
> >  	has_dre =3D of_property_read_bool(node, "xlnx,include-dre");
> >
> > +	of_property_read_u8(node, "xlnx,irq-delay", &chan->irq_delay);
>=20
> Same question here too

This is an optional property. If it is not there, then driver programs
 this value as zero and it does not break existing functionality. =20

>=20
> > +
> >  	chan->genlock =3D of_property_read_bool(node, "xlnx,genlock-
> mode");
> >
> >  	err =3D of_property_read_u32(node, "xlnx,datawidth", &value);
> > --
> > 2.25.1
>=20
> --
> ~Vinod
