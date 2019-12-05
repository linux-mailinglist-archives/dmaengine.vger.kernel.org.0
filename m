Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AB3114818
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2019 21:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfLEU2D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Dec 2019 15:28:03 -0500
Received: from mail-eopbgr760087.outbound.protection.outlook.com ([40.107.76.87]:8902
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfLEU2C (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Dec 2019 15:28:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzSDgxMGZcbE6Q31MEbhL6LRnnmlATtmofd0THZxNTFAXVodoMRyvVJrppd2FxGK3oWjp1AAXKniUdDAq1LljYU5E//23h2JqTq09C3A/IrexhGwK7WNcc8RTXfE+Gw/vxKmi1Q7mgoLsJa8RkTaAntPWBghiAznH9E+vp9KUubKfQTKrQeD0esMOftoxjMW8ARtk8vuNXMBehBgWmp25AYJwXNMwYIcK7XYstxOVMYzkHOliWW+0tJTUCHw/B6joPFRRJAxSU/d7SvldLW2BBRLSaa1q06LjyoqhEbS52EdeWUOm7J+jPbZ5KHuHVmdvYDFWK4FpUIZbu2N7CtH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oTmKkeucpPjT5Fji27ONaj4c6hosb+/RW+4pZy11Lo=;
 b=Ao88hb8IoxI7GF9TDSJwcwpQ78o2Gn6Wacvit8tc50mrTHDRIZAaVlcYPMLJE56OYokv4fCnnHkJTWrGz7GXt44rlOUtOf1aQS+p5XAaZj2HzkYKBgPUGTD8tTU3RtEFM8YqWurMcoVFrgXpX97gCns+a6S96pQv1lPOYgjn1/0jcuhzA8aCPG+AxZ49+Zv4gxc6LLgGgC+lk5b4pv8Un33OpIqLPSLLBdH6LBh3/ECXmi5mIfuO7luruYEo0H73a/H8YOK7en8hcAZXEzcF0NwHXI/huMaRs/uIrp+VvL3GQRN8/m0a2+6MQyR+UorIKLBpPM2zVoisw1FXE1OaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oTmKkeucpPjT5Fji27ONaj4c6hosb+/RW+4pZy11Lo=;
 b=jpVou1UL5uuBSFCvgDB85DkxHBv8IOPaan2/c3rSrcsM5ZwYFN2NIA4ZPF61GiLdeDEyLCze9W4VlGZhLr8gzCs+8bTFOB+XMTrDly6r2BbmlXeDBAFJNCqbTeZR8VOZz470FTZXxm5VwzBdR8JjVnU07CRgQsIgM93Tl/PbXg0=
Received: from BL0PR02CA0094.namprd02.prod.outlook.com (2603:10b6:208:51::35)
 by MWHPR02MB2271.namprd02.prod.outlook.com (2603:10b6:300:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Thu, 5 Dec
 2019 20:27:57 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BL0PR02CA0094.outlook.office365.com
 (2603:10b6:208:51::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Thu, 5 Dec 2019 20:27:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 5 Dec 2019 20:27:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1icxjA-0000pO-HB; Thu, 05 Dec 2019 12:27:56 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1icxj5-0005lH-Dz; Thu, 05 Dec 2019 12:27:51 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB5KRlvr001474;
        Thu, 5 Dec 2019 12:27:47 -0800
Received: from [172.19.2.244] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1icxj1-0005l7-JN; Thu, 05 Dec 2019 12:27:47 -0800
Date:   Thu, 5 Dec 2019 12:27:47 -0800
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Hyun Kwon <hyunk@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v2 2/4] dma: xilinx: dpdma: Add the Xilinx DisplayPort
 DMA engine driver
Message-ID: <20191205202746.GA26880@smtp.xilinx.com>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
 <20191107021400.16474-3-laurent.pinchart@ideasonboard.com>
 <20191109175908.GI952516@vkoul-mobl>
 <20191205150407.GL4734@pendragon.ideasonboard.com>
 <20191205163909.GH82508@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205163909.GH82508@vkoul-mobl>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(54094003)(189003)(199004)(76506006)(58126008)(16586007)(316002)(8676002)(70206006)(305945005)(53546011)(70586007)(9786002)(966005)(11346002)(54906003)(44832011)(1076003)(426003)(478600001)(5660300002)(356004)(336012)(36386004)(107886003)(2906002)(57986006)(76176011)(6916009)(8936002)(4326008)(229853002)(50466002)(26005)(81166006)(23676004)(81156014)(14444005)(186003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2271;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57be8f6e-7dc6-4c8a-718a-08d779c19d5f
X-MS-TrafficTypeDiagnostic: MWHPR02MB2271:
X-Microsoft-Antispam-PRVS: <MWHPR02MB22715623221B1A609567FF09D65C0@MWHPR02MB2271.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivBYac3lQXJ3peS/3ZEqesyDwhfvTbwRL+wBg15mIQJtmcC4UPZr5rqyu+Un2jaRjI6e9tUaFfUBq8TJ5Y0njnJ4DgeGEeB1CeAcurUgukHZOU8T+WPnxlS15Gdq6qQ7JxPc4mY9QzDP56Zxw2CBKZPXNcAD4noAGwsvtYQ47ODg41vyZ//YYItWr87lgphvXJMSEm3Gu7W55dwOD4nATsRc7Q/k4ozbqiS20yul0a++Dtdep3IR2L41znnEGvb2vUHuPlbwo1wZEhr5xvik6g4kPV486/k5zMTvGdo/k9aj1QHU5PIBvhG0eUKFte880A9VH4dB8AMpS8A7BDJZKkJqMfeGPlmzJoUgzxuixpgFPyCMO+fXB80f4pcYNvdF2wE3pvkrtQxZALbKysqrXX+YT70xgtYsSL5h2u6Q2QCu+jE9vtT4F3mtc0O1VFdV7KFkY33p2flu0kq4wlPIaL4ldChQBsTGSJ0dxlXoqQ3ui8hQKAvUWvJg8XKintnt23o9mxBVRy0mt1078/Brbg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 20:27:57.0410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57be8f6e-7dc6-4c8a-718a-08d779c19d5f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2271
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On Thu, 2019-12-05 at 08:39:09 -0800, Vinod Koul wrote:
> Hi Laurent,
> 
> On 05-12-19, 17:04, Laurent Pinchart wrote:
> > > > +/*
> > > > + * DPDMA descriptor placement
> > > > + * --------------------------
> > > > + * DPDMA descritpor life time is described with following placements:
> > > > + *
> > > > + * allocated_desc -> submitted_desc -> pending_desc -> active_desc -> done_list
> > > > + *
> > > > + * Transition is triggered as following:
> > > > + *
> > > > + * -> allocated_desc : a descriptor allocation
> > > > + * allocated_desc -> submitted_desc: a descriptor submission
> > > > + * submitted_desc -> pending_desc: request to issue pending a descriptor
> > > > + * pending_desc -> active_desc: VSYNC intr when a desc is scheduled to DPDMA
> > > > + * active_desc -> done_list: VSYNC intr when DPDMA switches to a new desc
> > > 
> > > Well this tells me driver is not using vchan infrastructure, the
> > > drivers/dma/virt-dma.c is common infra which does pretty decent list
> > > management and drivers do not need to open code this.
> > > 
> > > Please convert the driver to use virt-dma
> > 
> > As noted in the cover letter,
> > 
> > "There is one review comment that is still pending: switching to
> > virt-dma. I started investigating this, and it quickly appeared that
> > this would result in an almost complete rewrite of the driver's logic.
> > While the end result may be better, I wonder if this is worth it, given
> > that the DPDMA is tied to the DisplayPort subsystem and can't be used
> > with other DMA slaves. The DPDMA is thus used with very specific usage
> > patterns, which don't need the genericity of descriptor handling
> > provided by virt-dma. Vinod, what's your opinion on this ? Is virt-dma
> > usage a blocker to merge this driver, could we switch to it later, or is
> > it just overkill in this case ?"
> > 
> > I'd like to ask an additional question : is the dmaengine API the best
> > solution for this ? The DPDMA is a separate IP core, but it is tied with
> > the DP subsystem. I'm tempted to just fold it in the display driver. The
> > only reason why I'm hesitant on this is that the DPDMA also handles
> > audio channels, that are also part of the DP subsystem, but that could
> > be handled by a separate ALSA driver. Still, handling display, audio and
> > DMA in drivers that we pretend are independent and generic would be a
> > bit of a lie.
> 
> Yeah if it is _only_ going to be used in display and no other client
> using it, then I really do not see any advantage of this being a
> dmaengine driver. That is pretty much we have been telling folks over
> the years.

In the development cycles, the IP blocks came in pieces. The DP tx driver
was developed first as one driver, with dmaengine driver other than DPDMA.
Then the ZynqMP block was added along with this DPDMA driver. Hence,
the reverse is possible, meaning some can decide to take a part of it
and harden with other blocks in next generation SoC. So there was and will
be benefit of keeping drivers modular at block level in my opinion, and
I'm not sure if it needs to put in a monolithic format, when it's already
modular.

> 
> Btw since this is xilinx and I guess everything is an IP how difficult
> would it be to put this on a non display core :)
> 
> If you decide to use dmaengine I would prefer it use virt-dma that mean
> rewrite yes but helps you term
> 

I made changes using vchan[1], but it was a while ago. So it might have
been outdated, and details are vague in my head. Not sure if it was at
fully functional stage. Still, just in case it may be helpful.

[1] https://github.com/starhwk/linux-xlnx/commits/hyunk/upstreaming?after=0b0002113e7381d8a5f3119d064676af4d0953f4+34

Thanks,
-hyun

