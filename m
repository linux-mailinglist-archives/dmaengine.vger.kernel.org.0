Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9B42907BF
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409082AbgJPOvc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 10:51:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35990 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409071AbgJPOvc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Oct 2020 10:51:32 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 665B14069A;
        Fri, 16 Oct 2020 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1602859891; bh=TpkaKdnKTZRmT/r7nztjhL5SYuSft3fSVybRLZZE8DM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZphByjoZBdswMcFNr1BZytR28doQUMsKFScCTjBwp+JxzJXpB37PgylYgZuOoV078
         Q0lCH7Eu+5UsFI94XY7HgSl6tMrdMRvRusDskGMybGPKjAecGA+ziCEYUAl4dgRAet
         CE/lMrGCLFK099WtF0ABozlsgdEI269M9YZPhyJC3i9hT/gz+oRWWOF2y1G4L42HHV
         8kwSfwRRRuRZw3gBgSvSi8LyLeM2LgCDD49/b2QfzMRKfELMYbukrua60Zzzs22bey
         5bXRgVob1ShYDIp/j4jXkToV+9OqV6ZM7i9oR50UXrz+QLg19+4usQITIRTcx6QPbq
         EmqfO7ZPP0FrA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 21AA9A0063;
        Fri, 16 Oct 2020 14:51:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7AD5540044;
        Fri, 16 Oct 2020 14:51:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=paltsev@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="li0X727v";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HATQ6wi0h3RAEHPR/zd7llo0Ax9tYkggg9iHBeHpNJ7HGT4XaEEWJvG6QxtEzMMEAD678ppQ9YC990hqHmbvG5bFBjZ1RvyVJqVjpD3L0ph6a/Y7OTfCq5EGHMwJ2yra7CGfedFMCSFeuA8Adm2vDxvK8BgW3e6sQghw6HU1oqZsG5YXvbAYvFSLPBpuEhbEP2xBkhtJ1zKTE0S+BpCgKrrb3WuCYrDgmL4VKu2EoFjSPWvs2zdT0N/kr0AIvZ/DBjt4iwZqZc2G46JtC0CwebX/gwoRhQPlUzjZ8RuT88WljeKZPnKncWl/7cQWcGVIdBes7d3wHbjlYfofWM5nlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgsrhNOg3UOcVXR6FtcYpZxh0y2cn7mzRYo2XDVk1yQ=;
 b=M5kNLlErXXAiPVGPP0glw3UXZRncqsHoM95Ka8q0txP2nxXc5nIDEqNx8FRU6gVxhS+sTKf/e9qc6VdQgcQjc5Djhwapzt/HFBwPKiOD9VXTotmbEC0pEPsehojuihual2h/o0+3s7qKFQZGzNTK4gs0LzeF/eazriZgk/EiXkk9/AZ0fi/kZ+E+crf3CyHaoHXe3UV2s4mtCZoeUyLEnsCEwupQAsSTP7REHSfqJMpGruJF8KzFftZ6aI0Dj3OkOp5Db7LxnHZR/lCQKALZEiW7bRItu3PdEqVhL+QiowHefpTy/1rhr8riuzJHR5x9cIrw7H7R5DhLIvxrn0oTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgsrhNOg3UOcVXR6FtcYpZxh0y2cn7mzRYo2XDVk1yQ=;
 b=li0X727vXvqbbZk/mgivuxFmQ5w1Pp68A5Gn3hZjXn9FLyejVSplmAX3kL5dQcb7//srRxjjYm/fA/I2cvHxo4gaRhJdjdioNKMz5Pt1JlvaGhOGQ/oX7kSb0wyaE6vKEA7DGtrTTl4njyIHKbfjVgkSu1/7AMRdqtGYpzkqsSE=
Received: from MWHPR12MB1806.namprd12.prod.outlook.com (2603:10b6:300:10d::21)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 16 Oct
 2020 14:51:29 +0000
Received: from MWHPR12MB1806.namprd12.prod.outlook.com
 ([fe80::3980:da08:bf18:e34e]) by MWHPR12MB1806.namprd12.prod.outlook.com
 ([fe80::3980:da08:bf18:e34e%2]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 14:51:29 +0000
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Topic: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Index: AQHWoFGD7e2+t8tiGkuS8ZJ5cJ0zdKmaVo9N
Date:   Fri, 16 Oct 2020 14:51:28 +0000
Message-ID: <MWHPR12MB18065E87CEE3FD28868EBB9BDE030@MWHPR12MB1806.namprd12.prod.outlook.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
In-Reply-To: <20201012042200.29787-1-jee.heng.sia@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [5.18.244.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 345a830d-86ba-47ff-c1bf-08d871e2f6e4
x-ms-traffictypediagnostic: MW3PR12MB4555:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4555D055A1DBF2D2086F7E4FDE030@MW3PR12MB4555.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pknRPi/AZhWFxlW8STIaTrGMPwFmYSO8r9dvjrkcNO/NTrbbuQWBHqCmg3GPGSyKSZQGCk1TkIjR8BmQbCw5Ek1UFFFWhyuM8NGYZkeA2nmcLypciuYnY5V6XnRjht7UMV0z3Y726KxLnWcEfpJIybmW7IZaveh/wBf0GHbs7JIWqpYfsQvBdQ8e7yHRZeD3ccahyn6SXyRYLIdv1wlsUn9QB5Z5lOVD6DoGuOiNodsYpMLIaNNYS8MZ4t9vjquXInfKzEE9rD1wtyw0GpZsBq1+EGwGNaxfkc5tRwVDNfEu4gEJ5nqAxu04jb4zuAx5VQXz3B35q4llTCDwGLhQIStPGgN4DMRF4c2VNYncOPmCe3f5NlLE+KA0BgumQ7pBu7lgTdwABYn8fJ0pTHKAzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(316002)(54906003)(107886003)(4326008)(5660300002)(26005)(9686003)(55016002)(66476007)(186003)(6916009)(66556008)(66946007)(64756008)(7696005)(66446008)(478600001)(52536014)(91956017)(76116006)(2906002)(86362001)(8676002)(8936002)(33656002)(6506007)(53546011)(71200400001)(83380400001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: g4bsFIyf0uLQXeR6Hyfz6qSiXy5+uXBzGDYy5/R9v4Z9iCkkz6Ks4JYNYYhpC3Duu2rs8TmgJPVG6A0fL5hNa5DAbTVac1kBowrI6JztjqSvUPIyqJTpgSlZtHyiHMr6MgEa5CVus+CTpQHec5DViZmZdDiF9wMJnbfXyRXz/+ScYmlsqTgVll+r5YI9feVTJVVAMX9dwA7kR4Ivs+vkD43Sy7b70cYXPecVhOClesDDSy1t3C5N/vy0ZK3tt7EG52yISGsRlGBWB+h/BuwHSyitcB3oE6FANMYqQGRyF7Fssi4Lb94QQQZordu1JtbHDhoxxT8NAW9VpgK2W0kxHyMdvz6f7+J7uZ5YKMn4imA1E36iwEvMLemF6wlCO6HDxmpGNJWYldcPnxC0jATAFlxocbFtOjGEoUTk4BB6KbRpBU5qTtcot3eOaxPUGVmH15OMuS87Zb3+YWC4nIJ3It8rDvDVYu9KVaUcpuSAUFLYkT53imUrHQSR2hCbvrGSC6w3rFrTVMR6Lm8vV7Z6yOWG80A0ScCJcZrWg5pQjW3DJ25Ki90r08rYZW82uW4FUhHhDy8D3XHoPf8HQm93YHxGFIvF7eabzh8oO3eOa9Au0myrTLR9FVXEl1aY2FfL/PXcBY49X14vgVfXpAzw+Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345a830d-86ba-47ff-c1bf-08d871e2f6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 14:51:28.9640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yr7i5fO3mJeosiSVdFGpulhG+oz4A3zYndC32D0YgSgbryIfsO+7dc6Ea3iWZYi9m63rkNH//DWa2VdgNnYjCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sia,=0A=
=0A=
Is this patch series available in some public git repo?=0A=
I want to test it on our HW with DW AXI DMAC.=0A=
=0A=
Thanks.=0A=
---=0A=
 Eugeniy Paltsev=0A=
=0A=
=0A=
________________________________________=0A=
From: Sia Jee Heng <jee.heng.sia@intel.com>=0A=
Sent: Monday, October 12, 2020 07:21=0A=
To: vkoul@kernel.org; Eugeniy Paltsev=0A=
Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-ker=
nel@vger.kernel.org=0A=
Subject: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay AxiDMA=
=0A=
=0A=
The below patch series are to support AxiDMA running on Intel KeemBay SoC.=
=0A=
The base driver is dw-axi-dmac but code refactoring is needed, for example:=
=0A=
- Support YAML Schemas DT binding.=0A=
- Replacing Linked List with virtual descriptor management.=0A=
- Remove unrelated hw desc stuff from dma memory pool.=0A=
- Manage dma memory pool alloc/destroy based on channel activity.=0A=
- Support dmaengine device_sync() callback.=0A=
- Support dmaengine device_config().=0A=
- Support dmaegnine device_prep_slave_sg().=0A=
- Support dmaengine device_prep_dma_cyclic().=0A=
- Support of_dma_controller_register().=0A=
- Support burst residue granularity.=0A=
- Support Intel KeemBay AxiDMA registers.=0A=
- Support Intel KeemBay AxiDMA device handshake.=0A=
- Support Intel KeemBay AxiDMA BYTE and HALFWORD device operation.=0A=
- Add constraint to Max segment size.=0A=
=0A=
This patch set is to replace the patch series submitted at:=0A=
https://urldefense.com/v3/__https://lore.kernel.org/dmaengine/1599213094-30=
144-1-git-send-email-jee.heng.sia@intel.com/__;!!A4F2R9G_pg!Nemc1rSHID2X4d8=
pr0LNF0nD9Odrn425GRV8MSTPDvPwE6a3iWPeylAJSaxwqXjfPapMO4U$=0A=
=0A=
This patch series are tested on Intel KeemBay platform.=0A=
=0A=
=0A=
Sia Jee Heng (15):=0A=
  dt-bindings: dma: Add YAML schemas for dw-axi-dmac=0A=
  dmaengine: dw-axi-dmac: simplify descriptor management=0A=
  dmaengine: dw-axi-dmac: move dma_pool_create() to=0A=
    alloc_chan_resources()=0A=
  dmaengine: dw-axi-dmac: Add device_synchronize() callback=0A=
  dmaengine: dw-axi-dmac: Add device_config operation=0A=
  dmaengine: dw-axi-dmac: Support device_prep_slave_sg=0A=
  dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()=0A=
  dmaengine: dw-axi-dmac: Support of_dma_controller_register()=0A=
  dmaengine: dw-axi-dmac: Support burst residue granularity=0A=
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support=0A=
  dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA=0A=
  dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields=0A=
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake=0A=
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD=0A=
    registers=0A=
  dmaengine: dw-axi-dmac: Set constraint to the Max segment size=0A=
=0A=
 .../bindings/dma/snps,dw-axi-dmac.txt         |  39 -=0A=
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 149 ++++=0A=
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 696 +++++++++++++++---=0A=
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  33 +-=0A=
 4 files changed, 783 insertions(+), 134 deletions(-)=0A=
 delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.=
txt=0A=
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.=
yaml=0A=
=0A=
--=0A=
2.18.0=0A=
=0A=
