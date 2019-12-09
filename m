Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B41168FB
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2019 10:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfLIJQg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 04:16:36 -0500
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:29832
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727370AbfLIJQg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Dec 2019 04:16:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWDzhDzFKd7DEVP+SrmN1fbkpjvxu0XDt6M0SuxMGZFqpckQcirCwCIq/6XAUn6lvmBqLitLSMrrQ3dAEAwg0UNQiAPWiSarKvVYiF4H32RmtmGdr3RbXoDGDpsUOPaYJLkY8Z6hfBQgp/p6JAkZwjXfbzDys/2E04kUc/nmykAvY91lY+QubH2zgwBl6jsYKc7d7bRN58kaP3X5bCoCkNyd11xSDhs5X/GrB2n69JbL1DIpvVAxWeWumqNu3Z1OFhoG/x5DLFBS4TnOlFhD6sEbuLjO51mwbxipuy74sAFEPccw09UXu5hXzUmmy16Dt8LVT4IzcUT9FV0ge8mVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ACUsr9MeoTLaHsFYoBOt5PpAow2E2HFdETLHOrvG7k=;
 b=YakHlpjQT6VBbGfM+DPcbY47ht2qASKvGZEo9d8+gl3S/s1VhJ7NN1yC1xhmgh7e1qJUEsQDLpZ7q+SxpXOQp3Qn71Yk1ymIvwgLBzJLnPWk1mpWl76/DTOZ6ioNM2rkcW6nKj1HmUgyLs24K8V2NKNthhPoSG6PIGq+/qQm+gtBjlFm/Y9o7+ZzqX9QaV0JdliJlJNXpfcoeTymQerbUWWhWJfWFnuLtkfNAodcUh8/6qdpKZ+SeKpwFWRvf4Y7seJZPDe2GdjqcJR17A+IemQQ/wtHpadgRv5P0D2AJqDwPADXR3jUSxcCT/3lfobxvz9HbZ+6w7dcTtiSxmVKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ACUsr9MeoTLaHsFYoBOt5PpAow2E2HFdETLHOrvG7k=;
 b=bhDV/olPjsB9Zd31YDVYIX6AwCbfqiXi4lWTureawv1jUrf/Dz2vi5dpvvxr+6W8lThxJ47E4edgcw3hQp50MMAtHhSYwlrxPpvUnK4NmkcmQ08gkZaKL6CGVU0OHVN3RP9p/H06EA5kff/cWg0aU+XD00uL+11rPj+RIvydPUs=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6493.eurprd04.prod.outlook.com (20.179.233.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Mon, 9 Dec 2019 09:15:50 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::100:f42b:82a1:68c2]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::100:f42b:82a1:68c2%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 09:15:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Peng Ma <peng.ma@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v3] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Topic: [v3] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Index: AQHVrm9ixVNwnMvsy0G4gu21x4yF3Kexg4wg
Date:   Mon, 9 Dec 2019 09:15:50 +0000
Message-ID: <VE1PR04MB6638C13336F3F87585AC17F189580@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20191209090110.20240-1-peng.ma@nxp.com>
In-Reply-To: <20191209090110.20240-1-peng.ma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 945531f5-d8c3-475b-a730-08d77c88629d
x-ms-traffictypediagnostic: VE1PR04MB6493:|VE1PR04MB6493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6493278E688D1EEED75AEAC189580@VE1PR04MB6493.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(74316002)(8676002)(110136005)(8936002)(26005)(305945005)(33656002)(9686003)(2906002)(71200400001)(81166006)(186003)(81156014)(316002)(71190400001)(54906003)(55016002)(76116006)(4326008)(66946007)(76176011)(7696005)(66446008)(64756008)(99286004)(66476007)(66556008)(5660300002)(53546011)(6506007)(52536014)(86362001)(6636002)(478600001)(102836004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6493;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZS/xMy5IfJvOEa3cyTLmFq0O4qSNpT0eYZAQ1SjLq4EsxJJkTEA6kZFRdJTRistL0xB+e0k40sFmhaAUkdgrIYJZ8sOR2S8e/ovhjw572MXzwQ80XPGUpPaM1jEa/a4HqhicJhWbeHgMm2Bk2nBaenOIZZ5Pjc5kXbQoWQLz5ajirnQCKdmIGBTAVjdrvd4EoyF1nM3ShldAmEViS70W+pw3M/CPk0YTLeO9sXNJTPZvZOs0F2XvfCh1iGVQ1OWj85q6gGvAiyT94lBqC2OydcTx7OqURbqupTb01rhRah6kTGIELzFEKkovTb/6IFamk1HiV+krSa2jIGDWVrMbRB4odLAxzL5ecLq/dBsCkS1pq17TrDaTYPdDSdsQG0qzGKgONkKF+izBUi9qmRpOMFWwclgY7KiVnU7AyXtrJS9bgvao2qYCXZmbdBtIw5i
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945531f5-d8c3-475b-a730-08d77c88629d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 09:15:50.6640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OQr3t9+cl0trjt88J3TqbvYsf/bqhvlPD7XBXBciJ1h2MQsz20nd6eQ3phQBy8fJGLoKkq/lKypRhAoAtvBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6493
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019/12/9 17:03 Peng Ma <peng.ma@nxp.com> wrote:
> Our platforms(such as LS1021A, LS1012A, LS1043A, LS1046A, LS1028A) with
> below registers(CHCFG0 - CHCFG15) of eDMA as follows:
> *-----------------------------------------------------------*
> |     Offset   |	OTHERS      |		LS1028A	    |
> |--------------|--------------------|-----------------------|
> |     0x0      |        CHCFG0      |           CHCFG3      |
> |--------------|--------------------|-----------------------|
> |     0x1      |        CHCFG1      |           CHCFG2      |
> |--------------|--------------------|-----------------------|
> |     0x2      |        CHCFG2      |           CHCFG1      |
> |--------------|--------------------|-----------------------|
> |     0x3      |        CHCFG3      |           CHCFG0      |
> |--------------|--------------------|-----------------------|
> |     ...      |        ......      |           ......      |
> |--------------|--------------------|-----------------------|
> |     0xC      |        CHCFG12     |           CHCFG15     |
> |--------------|--------------------|-----------------------|
> |     0xD      |        CHCFG13     |           CHCFG14     |
> |--------------|--------------------|-----------------------|
> |     0xE      |        CHCFG14     |           CHCFG13     |
> |--------------|--------------------|-----------------------|
> |     0xF      |        CHCFG15     |           CHCFG12     |
> *-----------------------------------------------------------*
>=20
> This patch is to improve edma driver to fit LS1028A platform.
>=20
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> Changed for v3:
> 	- Rename struct soc_device_attribute
>=20
>  drivers/dma/fsl-edma-common.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/dma/fsl-edma-common.c
> b/drivers/dma/fsl-edma-common.c index b1a7ca9..10234e1 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/sys_soc.h>
>=20
>  #include "fsl-edma-common.h"
>=20
> @@ -42,6 +43,11 @@
>=20
>  #define EDMA_TCD		0x1000
>=20
> +static struct soc_device_attribute mux_byte_swap_quirk[] =3D {
> +	{ .family =3D "QorIQ LS1028A"},
> +	{ },
> +};
> +
How about add 'mux_swap' into 'struct fsl_edma_drvdata' instead
of involving any soc type into the common fsl-edma-common.c? Then
soc type could be added into chip level driver fsl-edma.c like "fsl,vf610-e=
dma"/
"fsl,imx7ulp-edma".

>  static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)  {
>  	struct edma_regs *regs =3D &fsl_chan->edma->regs; @@ -109,10 +115,16
> @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
>  	u32 ch =3D fsl_chan->vchan.chan.chan_id;
>  	void __iomem *muxaddr;
>  	unsigned int chans_per_mux, ch_off;
> +	int endian_diff[4] =3D {3, 1, -1, -3};
>  	u32 dmamux_nr =3D fsl_chan->edma->drvdata->dmamuxs;
>=20
>  	chans_per_mux =3D fsl_chan->edma->n_chans / dmamux_nr;
>  	ch_off =3D fsl_chan->vchan.chan.chan_id % chans_per_mux;
> +
> +	if (!fsl_chan->edma->big_endian &&
> +	    soc_device_match(mux_byte_swap_quirk))
> +		ch_off +=3D endian_diff[ch_off % 4];
> +
>  	muxaddr =3D fsl_chan->edma->muxbase[ch / chans_per_mux];
>  	slot =3D EDMAMUX_CHCFG_SOURCE(slot);
>=20
> --
> 2.9.5

