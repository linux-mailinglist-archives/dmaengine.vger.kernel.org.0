Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4BEC09D8
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfI0QxQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Sep 2019 12:53:16 -0400
Received: from mail-eopbgr720086.outbound.protection.outlook.com ([40.107.72.86]:51904
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfI0QxP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Sep 2019 12:53:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZlT8i7elFF9OiYgknj2iGBhIy593n+4b/63CFUJBz8089jAjTfhkpy6hC1amo2dea0fNReeNpXc1heksfzK/QE5dtlvUtSXSefu4zpPFCcXdyq6xiP/keo466Jc31zrn21YMWPzdg39BDIjuRcXERaq7Akvh7bj1NzDf9LntmqRBzXNEOcw2nQCnSNMlP3arpPGrAAV5es0OgJysweSYC6fuB+sJBinImCoyR+p5/A1JVdAyAFld21vZy0JX78knHWsZBR+mDdzAbilFd1vlU8dqWZF3UbI+eQgxAbO6sf/0WEmOb2h8+bOIui4ihuVbZWnE+1FM9KW9Csy4NLurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfZABY3KvNgVN3V6mgMTRmxTMxYgnsc92XpSywvDk+w=;
 b=halAoXYxwcI3kTzJRdRm7LFl7r8QISS8cx5u7FyJKjA/jLmQgRhy+J6PBvk7KTw1gvkkMjnSAog10NtxNxb8EAsc7JWnZ14hZ3Pv9pioQEywRNEe4Jn5UFQbXIkIIXllgKkz0tGAjNLWEk70uL1XctZpDJT0YvfclWLAbc79ralVRCMG2Cfz58Hig0UaB/PAKS0iI2rILUYLiwPUi7w7XD5j2HR4tzPpOypCVNlO6A6K8QACVu6H9NgeeYs9KDD6G+wPbyio2FNXKVkGeOQDFS7DhWNOOevWPrDhtKb8EiKJ+WwFtsp/2A8XFPJfb882VKwUyFXMoYhE0b30slR3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfZABY3KvNgVN3V6mgMTRmxTMxYgnsc92XpSywvDk+w=;
 b=hho/UIsocjyPG0zwmi7uHMr1chBa1MsPUuL45Lt7YxEQqz3K6rJbFExES/Yues8Kc4+p53e2cgOb3lnFjRjM2t0oViJQhbILGlf3NE+WT0GVw+vhQHbxP3OgAYwmjjL7cTtZW4h3yCobVkN15V4NIV0UvbnafaPiVc8gjI9XQL8=
Received: from CH2PR02MB7000.namprd02.prod.outlook.com (20.180.9.216) by
 CH2PR02MB6773.namprd02.prod.outlook.com (20.180.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 16:53:11 +0000
Received: from CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd]) by CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 16:53:11 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Nicholas Graumann <nick.graumann@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle and
 halted state in axidma stop_transfer
Thread-Topic: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle and
 halted state in axidma stop_transfer
Thread-Index: AQHVZAh+BsqD15rQs0ybdZW78qGrBqc+VX+AgADPhOCAAInhAIAALOvg
Date:   Fri, 27 Sep 2019 16:53:11 +0000
Message-ID: <CH2PR02MB7000D0EF8E2B2C11C58B7235C7810@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-8-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20190926172107.GN3824@vkoul-mobl>
 <CH2PR02MB7000EACD029FC7E47679393CC7810@CH2PR02MB7000.namprd02.prod.outlook.com>
 <20190927135720.GA16057@lnx-nickg>
In-Reply-To: <20190927135720.GA16057@lnx-nickg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d791a120-0008-4f34-43a4-08d7436b2e5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6773;
x-ms-traffictypediagnostic: CH2PR02MB6773:|CH2PR02MB6773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB677370C4944BB93FA926F871C7810@CH2PR02MB6773.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(199004)(189003)(13464003)(26005)(6916009)(9686003)(14454004)(25786009)(11346002)(6246003)(446003)(7736002)(4326008)(74316002)(476003)(229853002)(71190400001)(486006)(6436002)(186003)(71200400001)(3846002)(305945005)(99286004)(256004)(7696005)(86362001)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(316002)(54906003)(478600001)(6116002)(53546011)(6506007)(2906002)(5660300002)(8676002)(102836004)(8936002)(81156014)(66066001)(76176011)(81166006)(52536014)(14444005)(55016002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6773;H:CH2PR02MB7000.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lYaqIoCs8JvrxVPrqn+Pd6KElGwfTZnmjTArLlq22r78DcJ3XIUcy5SJYjplmROmF4q6xGg8Io3NL//HU/hgTNoK9UyO8g5KRx7wBD+SbFuKnjYY7cOlMCazToFRGotksx6bI1JjjUZ2OfyQ1zsTTYr1MxzERY7vxeTBPFavY6jQyumDIRAunVbHF1N6sCzRWlJ/0oMntJauWXUwFQAh76CAIDhcc1k8xUIpKd9P+oB9j7O/YEn0GY4+xZD3ZxC+J5O+TbNfob5KBsxclLK4nOWQIz/fzLkcnP00Fjt/qsYEwc2S/Uf811uld8FxXjQMFfYLuNxhXNz4e5JHweGDiVQ8X0Fp0dFhGyhcl4df0SC0NF8fuQ/15dnBLUTxh2IY26jBiVFpBSRj1Xw97H7X8wQPBYgIeWPrsC6TiXDPxJY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d791a120-0008-4f34-43a4-08d7436b2e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 16:53:11.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajvgXI8umiYrTSEEOD2sE92S30L2l+7zsKoScpfc0NfXXW9zSzft7DyOwmB2vu6r3xtYUYtgQGHnfDtIpyYbHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6773
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Nicholas Graumann <nick.graumann@gmail.com>
> Sent: Friday, September 27, 2019 7:27 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: Vinod Koul <vkoul@kernel.org>; dan.j.williams@intel.com; Michal Simek
> <michals@xilinx.com>; andrea.merello@gmail.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle
> and halted state in axidma stop_transfer
>=20
> On Fri, Sep 27, 2019 at 06:48:29AM +0000, Radhey Shyam Pandey wrote:
> > > -----Original Message-----
> > > From: Vinod Koul <vkoul@kernel.org>
> > > Sent: Thursday, September 26, 2019 10:51 PM
> > > To: Radhey Shyam Pandey <radheys@xilinx.com>
> > > Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> > > nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> > > Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> > > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both
> idle
> > > and halted state in axidma stop_transfer
> > >
> > > On 05-09-19, 22:07, Radhey Shyam Pandey wrote:
> > > > From: Nicholas Graumann <nick.graumann@gmail.com>
> > > >
> > > > When polling for a stopped transfer in AXI DMA mode, in some cases
> the
> > > > status of the channel may indicate IDLE instead of HALTED if the
> > > > channel was reset due to an error.
> > > >
> > > > Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
> > > > Signed-off-by: Radhey Shyam Pandey
> > > <radhey.shyam.pandey@xilinx.com>
> > > > ---
> > > >  drivers/dma/xilinx/xilinx_dma.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > > b/drivers/dma/xilinx/xilinx_dma.c
> > > > index b5dd62a..0896e07 100644
> > > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > > @@ -1092,8 +1092,9 @@ static int xilinx_dma_stop_transfer(struct
> > > xilinx_dma_chan *chan)
> > > >
> > > >  	/* Wait for the hardware to halt */
> > > >  	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR,
> > > val,
> > > > -				       val & XILINX_DMA_DMASR_HALTED, 0,
> > > > -				       XILINX_DMA_LOOP_COUNT);
> > > > +				       val | (XILINX_DMA_DMASR_IDLE |
> > > > +					      XILINX_DMA_DMASR_HALTED),
> > >
> > > The condition was bitwise AND and now is OR.. ??
> >
> > Ah, it should be same as before . Only _IDLE mask should be in OR.
> >
> > Also on second thought to this patch- we need to describe which error
> > scenario "in some cases the status of the channel may indicate IDLE
> > instead of HALTED" as mentioned in commit description.
> >
> > @Nick: Can you comment?
> >
> In regard to the mask question, yes, this looks like a bug.
> We should be AND'ing with the mask like before.
>=20
> As far as the state, usually when we saw the IDLE state when invoking
> dmaengine_terminate_all on a channel that had errors. I have not
> proved this, but I believe what happened was the following:

As per IP produce guide pg021, once DMACR[RS] is set to 0x0
the halted bit in the DMA Status register should asserts to
0x1 when the DMA engine is halted. Also the DMA may be the
in IDLE state, there may be active data on the AXI interface.

I think for now we can skip this patchset in v2 and repost it
when a proper root cause is done.

>=20
> New transactions were queued when chan->err was set, causing
> xilinx_dma_chan_reset to be invoked which ultimately results in the
> hardware being in an IDLE state by the time xilinx_dma_terminate_all
> gets around to invoking stop_transfer. At that point, stop_transfer is
> going to time out waiting for the hardware to indicate it has HALTED and
> ultimately will time out.
>=20
>=20
> In any case, xilinx_dma_stop_transfer should be fine with the hardware
> being in an IDLE state to indicate that the active transfer is stopped.
> Case in point: The CDMA core also covered by this driver only has an
> IDLE bit and no HALTED bit in its DMASR, and it checks for just the IDLE
> bit in xilinx_cdma_stop_transfer().
> > >
> > > > +				       0, XILINX_DMA_LOOP_COUNT);
> > > >  }
> > > >
> > > >  /**
> > > > --
> > > > 2.7.4
> > >
> > > --
> > > ~Vinod
