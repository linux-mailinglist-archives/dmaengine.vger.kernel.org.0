Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0C1126F1
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2019 10:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfLDJUD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Dec 2019 04:20:03 -0500
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:38533
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfLDJUD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Dec 2019 04:20:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ellcuqNu/Jy7Eaav6mjOgR6dVMucSadJUblpUKdT84Se1flGGF/JYlCgCBLHRoJPAvIUq/92/FLjmkkrBjFaR3+oKCkn5yCkuQmJWks4wZhanGN2lAT7hMckAUKj0j4ZGupdwxKPNZdPvWzVE4x1AYsg7jh3f+P2M09y2CmhNPYe7q1mq9MFoQXWjOWmcSvfZMTARvEkFCKfAkknBJrzp9fBAYL/6MJOd/rdqmrUR/WjA3/SRx5Pwv5lK/qLQy5irWggkfgKvFaCyH3nEjfHFN/FfaBHzl1mJnNGvAHIzirJpzXKLnGZD/fG+zdMxnRVhg/gQ+J6g9ZEobvhTGlXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZVyHOgk7TYJe2eRsgGmRu9EdrfHo3xF1bFy1m0FNtU=;
 b=GfzxvPKZ22KM5OInCZLJV3gU+V/VRsT/6Zq2OylRtYxpZKkGeEIJpBWAwlDROefWBpshFYwvWPnlNXr2nCPIfIQ2WKqNDhGAbaGxbVTfvTLG+wkRav90HnvnMBBoTgL+TzCuNqszPGfO8zUK3+zw5PnTI14/22cJMc+OXVrLpnIVZEuq0doFTJ+cbcGTyI70mxmsAGCobWAgXwyG2Mr05xMuAt3pHOmtlfSSkgbQjhORxwojLE33JBa2TkTnhW2judg/vXG0/L6+tjjPwodopFmkTCcKzkAeF24RhLf0h56+DAR40SMM14r3/ssT3t9YdpgsBrCbTN3bLWUqgzkn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZVyHOgk7TYJe2eRsgGmRu9EdrfHo3xF1bFy1m0FNtU=;
 b=ji6VCDz9QlNDv1Pf3/2Gg1AQ/owNit8VgByAmu58rbDCRW89FB+gHXDgAob+qiCIFwFUaLMXd7uN5W/JfVPSs4ThzG8Y4iouRBDs8xecl5ksXrWwfLOjmyOfkLvvXsruwQU810i94cDzgIwlwp/mDDGGanBOJIF3MtbmzOhzzPI=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6350.eurprd04.prod.outlook.com (20.179.234.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 09:19:59 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::100:f42b:82a1:68c2]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::100:f42b:82a1:68c2%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 09:19:59 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jlu@pengutronix.de" <jlu@pengutronix.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 1/3] dmaengine: imx-sdma: fix buffer ownership
Thread-Topic: [PATCH v5 1/3] dmaengine: imx-sdma: fix buffer ownership
Thread-Index: AQHVchby6WsIv+QhqUqHYVdym6wSTaeqHbhA
Date:   Wed, 4 Dec 2019 09:19:59 +0000
Message-ID: <VE1PR04MB6638A9E882D40FB7F8CB7F14895D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
 <20190923135808.815-2-philipp.puschmann@emlix.com>
In-Reply-To: <20190923135808.815-2-philipp.puschmann@emlix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f160f391-13ae-403e-f335-08d7789b22c9
x-ms-traffictypediagnostic: VE1PR04MB6350:|VE1PR04MB6350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB63509C5B616A63AE92B97C9B895D0@VE1PR04MB6350.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(54534003)(189003)(199004)(86362001)(4001150100001)(6506007)(8936002)(7736002)(81166006)(76116006)(2906002)(66446008)(9686003)(71190400001)(6116002)(71200400001)(33656002)(478600001)(5660300002)(305945005)(52536014)(99286004)(14454004)(26005)(2501003)(7696005)(3846002)(81156014)(74316002)(76176011)(102836004)(14444005)(11346002)(66946007)(66556008)(8676002)(186003)(229853002)(7416002)(256004)(446003)(25786009)(4326008)(110136005)(54906003)(64756008)(6246003)(316002)(66476007)(6436002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6350;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqRbV/VNwT0dJeGLtRISVBiy2xibEFS8vrKif1RMiP6FQodk9R1wiFNgkmNL8uj7bPb02snlETBZEg0wmf0Ezva80CTwKcbxI0OaXY2VsmGLmrcGik/1EcivKqRMZ+JBP4jesXnXOZtD9HTO8SddcMsmeOQOrfmvH8MscXa6hdkb3B88LkAioF+SDVrDZ7y6RTlVmwG5vlL0sjZ6LXKapLlbSsE1/H1TCrkm5fAJjeVKnjIC3l2YpsWWAhNTA8jtilgycnrqRts01qtOkUqFLNH5Fji540q+oHySFYwokX/8Q+KQJBlPUGInahSNCbNHPBnjRgUyk72XCTxH2CpyMpqFAOW+Obekkzt/6Cw9gohfEEi8vuIUxP3a6K50ScTHav261orUMyZ9mkh+wiN3ZJv/pFoI3MB4M5eAD3INVTfN6QlFr0djufPO3lM1wFtYVa/Ym3fgQ5Pal5ZTZIlwqoUvbPOyFRBhgNeCNxXjG86a70Q99vTlL8KB+QYeNpES
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f160f391-13ae-403e-f335-08d7789b22c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 09:19:59.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PL+N9ws3Zt9VOmqrwTRm7mkdqaM3Whjr79+TdTMjCche7qQXX7temTU4G0rwKnX1EjL3dDPLiRmvPN84gpD8iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6350
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019-9-23 Philipp Puschmann <philipp.puschmann@emlix.com> wrote:
> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the buffer,
> when 0 ARM owns it. When processing the buffers in
> sdma_update_channel_loop the ownership of the currently processed buffer
> was set to SDMA again before running the callback function of the buffer =
and
> while the sdma script may be running in parallel. So there was the possib=
ility to
> get the buffer overwritten by SDMA before it has been processed by kernel
Does this patch need indeed? I don't think any difference here move done fl=
ag
before callback or after callback, because callback never care this flag an=
d actually
done flag is setup for next time rather than this time. Basically, this fla=
g should be
set to 1 quickly asap so that sdma could use this bd asap. If delay the fla=
g may cause
sdma channel stop since all BDs consumed. Could you try again your case wit=
hout
this patch?
> leading to kind of random errors in the upper layers, e.g. bluetooth.
>=20
> Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> ---
>=20
> Changelog v5:
>  - no changes
>=20
> Changelog v4:
>  - fixed the fixes tag
>=20
> Changelog v3:
>  - use correct dma_wmb() instead of dma_wb()
>  - add fixes tag
>=20
> Changelog v2:
>  - add dma_wb()
>=20
>  drivers/dma/imx-sdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> 9ba74ab7e912..b42281604e54 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct
> sdma_channel *sdmac)
>  		*/
>=20
>  		desc->chn_real_count =3D bd->mode.count;
> -		bd->mode.status |=3D BD_DONE;
>  		bd->mode.count =3D desc->period_len;
>  		desc->buf_ptail =3D desc->buf_tail;
>  		desc->buf_tail =3D (desc->buf_tail + 1) % desc->num_bd; @@ -817,6
> +816,9 @@ static void sdma_update_channel_loop(struct sdma_channel
> *sdmac)
>  		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
>  		spin_lock(&sdmac->vc.lock);
>=20
> +		dma_wmb();
> +		bd->mode.status |=3D BD_DONE;
> +
>  		if (error)
>  			sdmac->status =3D old_status;
>  	}
> --
> 2.23.0

