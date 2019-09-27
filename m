Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04610BFF5B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 08:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfI0Gsd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Sep 2019 02:48:33 -0400
Received: from mail-eopbgr760042.outbound.protection.outlook.com ([40.107.76.42]:25285
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfI0Gsd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Sep 2019 02:48:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNKLX2R9lpZNJAVdg35C+BL+cpy34orkahShtdH+VIyt2jn4IBE0umSusvdP+LJAY2OCruqLhwlV8ErS1YnlHygJX83FcRcZL6t40XqSLdcErSgxdSwJykMGVEXZ1nYUyEtkR5fP2Os9N2nTYfIXTLqhk6wOit7/zPmouRoo63DWFI4h1/mQ/UWr9DuoucR2WUZXf8VQSKVqA/lkJ6UP6xnNxPbkKevRVKg77RSoQUwZu7tPKi6V3+lwSmoRKkxE8+qz8ElCW4UB74+fwV+sHr8C7CVzB7PPDZt2bjTz4AI/i4+zkcz8pTH27Ko+hQHgZeN9XBB8BGB4iKXFCgxaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+BgMy+irracLfuK8xlguqxJRh2xcsiqApnbgGKjRYk=;
 b=SjAbEgnDHum3V5qTDemd9kWzMBJf4Thi62goctvjr1+N1Q5vANpvjzIm3JzVA1NvNBwcb6ccXOMpr0LZmwFwHirRF/UnIawLFkthWta9yyQW2gTvikw0QFuFQDw1V8gaZXPMdjFTNK5OLWMnZ25/xavYRust3cEwAdzRpcE2enonJSwVOBOrOOIyMLP4+aTvkpHJf7DpFpyHH4ht9csJmw9smf1/Tw2ARZuiRQb6+1o+HzmPK2cOWD7oqiw0YeSEAQq2GXy1u0Kp1zWpHT23zb+7oWc9RUKVwRS0Yp7ZoEZqRzQ2pceDumDZjw3urtASMUOkejJ1TPXWT644wZqDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+BgMy+irracLfuK8xlguqxJRh2xcsiqApnbgGKjRYk=;
 b=ZFuxrg7nLAxFHsjxrRMu7ehjn7CF3k0+wjtDDoKDfc7OTQT0bozYj+G9YIMouUJc1VQ8LEus5YEQLP4c0z4IkH2eV71ljfTy4z1qU5bSCPHRZS62ScPow9t+js9lw6CvznimK7P3SniY1g9JY1vQQPg3Jd4NBNQ7QyMudYRNDDY=
Received: from CH2PR02MB7000.namprd02.prod.outlook.com (20.180.9.216) by
 CH2PR02MB6693.namprd02.prod.outlook.com (20.180.6.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 27 Sep 2019 06:48:29 +0000
Received: from CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd]) by CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 06:48:29 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "nick.graumann@gmail.com" <nick.graumann@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle and
 halted state in axidma stop_transfer
Thread-Topic: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle and
 halted state in axidma stop_transfer
Thread-Index: AQHVZAh+BsqD15rQs0ybdZW78qGrBqc+VX+AgADPhOA=
Date:   Fri, 27 Sep 2019 06:48:29 +0000
Message-ID: <CH2PR02MB7000EACD029FC7E47679393CC7810@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-8-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20190926172107.GN3824@vkoul-mobl>
In-Reply-To: <20190926172107.GN3824@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 826690e6-4397-47cb-98ea-08d74316b4ba
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR02MB6693:|CH2PR02MB6693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB6693F79A84F2232B849BE34CC7810@CH2PR02MB6693.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(189003)(199004)(13464003)(52536014)(5660300002)(99286004)(71190400001)(256004)(11346002)(8676002)(229853002)(81166006)(81156014)(305945005)(476003)(74316002)(7736002)(8936002)(446003)(66066001)(76116006)(71200400001)(14454004)(102836004)(26005)(6506007)(478600001)(186003)(64756008)(486006)(66946007)(66476007)(66556008)(25786009)(76176011)(53546011)(66446008)(86362001)(6246003)(6916009)(7696005)(55016002)(9686003)(4326008)(54906003)(316002)(33656002)(6436002)(2906002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6693;H:CH2PR02MB7000.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+poyYr9nlOMJpGo6zIrXLqsqxvQlpPEmJMyPLaZW52IkEaqOpVkDdRPLknfnTNJx5WKL5yTQHU+UJ2q/C60Clo1C6F/57UIXO86wtMJQjr8l9tgmpEJsana90TEY1zyXXgydSrGWcgi/qhPd1CdxV/4p9RWWrA3i1HDicwWxXGLaohRx8ZBc96FVgv/R8Cb5SveQCMt1FWBd/QbSR1FKY1wzV/Xsu04JpfiaQRe0MsB9VLjDRSSyJ78B2wdlIop24mmuuePuGYsd0gjXpk1LH6R2SejgUdUI9OVjpuGT39zPpftDWL+l+P/SMfm/wmGmytJHDF8PXHIWRkZW2OzLixmt4pzXRKHkMV4Rv5GTZzXiJyrcOsVzOS3m1NrfGZnlg70cnMDbaM/OGJUlhz2bihLNSN+X0ZR3Y1g4SpASi0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826690e6-4397-47cb-98ea-08d74316b4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 06:48:29.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PjpEcbixfTK08+yL/nB92eZvCk35RvmMEFIVm5s3zdh1m/Dy1PeqihCc40E1A4M3tHpJFypaphBxrrmF8wy+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6693
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, September 26, 2019 10:51 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle
> and halted state in axidma stop_transfer
>=20
> On 05-09-19, 22:07, Radhey Shyam Pandey wrote:
> > From: Nicholas Graumann <nick.graumann@gmail.com>
> >
> > When polling for a stopped transfer in AXI DMA mode, in some cases the
> > status of the channel may indicate IDLE instead of HALTED if the
> > channel was reset due to an error.
> >
> > Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
> > Signed-off-by: Radhey Shyam Pandey
> <radhey.shyam.pandey@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c
> > index b5dd62a..0896e07 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -1092,8 +1092,9 @@ static int xilinx_dma_stop_transfer(struct
> xilinx_dma_chan *chan)
> >
> >  	/* Wait for the hardware to halt */
> >  	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR,
> val,
> > -				       val & XILINX_DMA_DMASR_HALTED, 0,
> > -				       XILINX_DMA_LOOP_COUNT);
> > +				       val | (XILINX_DMA_DMASR_IDLE |
> > +					      XILINX_DMA_DMASR_HALTED),
>=20
> The condition was bitwise AND and now is OR.. ??

Ah, it should be same as before . Only _IDLE mask should be in OR.

Also on second thought to this patch- we need to describe which error
scenario "in some cases the status of the channel may indicate IDLE
instead of HALTED" as mentioned in commit description.

@Nick: Can you comment?

>=20
> > +				       0, XILINX_DMA_LOOP_COUNT);
> >  }
> >
> >  /**
> > --
> > 2.7.4
>=20
> --
> ~Vinod
