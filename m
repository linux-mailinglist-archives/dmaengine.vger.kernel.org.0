Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0BCBC2A9
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 09:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfIXHbF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 03:31:05 -0400
Received: from mail-eopbgr730062.outbound.protection.outlook.com ([40.107.73.62]:36400
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfIXHbF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 03:31:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgy/gtaOGKQ+sNE9u7IuZAV0lZLfDqxgDeRRxs9/gbb07zb+/MRlwgg4pyAe3ReSh/N1q4ek+wQF26BphwvJa2aEYUy/CAbUCKZe9SZrcO+O7Zfm0EJ+TAVtvkB/IZMGl12bPqXEHqulomCy/0HLCv+Ovifd5gUrfHGTBYIltOoy6rwfNHdVyCQ+rrEO+P2I3ncLV7CVnDPFgV0jOWzrGXrgbt6OehDNxGyDDMc+IHe7P6U0mwW+gdHU0jzkupun/TDwr4U7ptNCfWUksNDpmCq1X2m2vg+ZRZ2bNWd82GwpMcHlEcAxAL+TYJIMa/OPN9KmdFT3vSVddRQwOR0S8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9KWIkoLuRTxmp3OtITsfmkrdtPzqi2SbrkKiVNSO50=;
 b=JpxbdDUunieVU26EFVgoSd9iz2KXThk6DRohiF9wcEvXG3JdqZjQtjaBqnrnRFe7H1u1SBrwrCswmgJnkGGjYh8/2RVM9brV/IkWMG8zuTh0e/iDLRWvwAWUsUoazpSU5BO3TL5hqYD4GfH87/bg0YlKoxZ7wvMdYZ8pZWBU57h2/76niewsSwDY5oJZKwDrX+o4cPMlt0hmhDGx495GFrSJobsblW+gLHaxDciCwpUzE8D8lMWYEhz/MwTGAy3EVj7o3s84c08Eq4EAzoKHVcr95vRuqDMx1r6pnn2i/A8ZaY4AO1h346xm6jnpyyhmZoDEg+BcCpzdWeKQp9Tiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9KWIkoLuRTxmp3OtITsfmkrdtPzqi2SbrkKiVNSO50=;
 b=20mSIpB1XtNO1Nvk/ZCuP6T+/ctk9f1VqOt2NIaRCGWpDEqmsbXWf4eQ/f8ZKV+O0GgbZrHFzPQEHEbXo5c37a3XA64ns5a6KjFyaWHNa2WxQAP7nvs2A+e3SwU6KfNLXIMinbUfmzMcnYEiYb6EiRWfTnf5bXYFYlROp+4HeDA=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3359.namprd12.prod.outlook.com (20.178.243.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:31:02 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:31:02 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 0/4] *** AMD PTDMA driver ***
Thread-Topic: [PATCH 0/4] *** AMD PTDMA driver ***
Thread-Index: AQHVcqoESUxZSvjG70+062OZ6XyZgg==
Date:   Tue, 24 Sep 2019 07:31:01 +0000
Message-ID: <1569310236-29113-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::22) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 404c7ee1-7280-4fcf-96d0-08d740c1266c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3359;
x-ms-traffictypediagnostic: MN2PR12MB3359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33590719E59CCB5F5C82C65BE5840@MN2PR12MB3359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(3846002)(6116002)(476003)(14454004)(478600001)(102836004)(25786009)(7736002)(2201001)(256004)(99286004)(186003)(2501003)(6506007)(2616005)(305945005)(4326008)(54906003)(66946007)(6512007)(86362001)(6436002)(5660300002)(7416002)(2906002)(66066001)(386003)(110136005)(6486002)(71190400001)(71200400001)(66476007)(8676002)(64756008)(52116002)(66446008)(66556008)(26005)(50226002)(486006)(36756003)(81166006)(316002)(8936002)(81156014)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3359;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q2nN0XjOCcIxwxuMTT4FV+9hAu780EPbXYNm92FghcjbTeBW4/QEnoEIit0xv7/MBJ9jf+0STcZZFfQ+kjj1/qd0+5XeqVERSg/AiuKiYhTqOkOTbuP92vZDLbzm4dMUV9TwhQaf4k4gWeYPt8jGEW5oLJVCYGOA9BLgmLUgiOO4iJZGqW6+PkygAzbwujCP9daRZ30lcvUb2RVNHauk9E1fmfWs429ORmXUTGZdPx9KSUXlaENTaJdL+8dXUWDQpfi4g1roPwFX+Dz1pWcRmcl2nojpTY8TsWuhEwJpZL7mc0KspaLpLdK/SEs4dU3USdV4kFrCvAXm4hAhhY6tx9TeHTo60yukFRq8eHrjxubgfVfJWPcnA9f4oD4ZBiWM8mNEIf6cJztNOsrY/QM6fXuWny408FnWzmdWTKnPVq8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404c7ee1-7280-4fcf-96d0-08d740c1266c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:31:02.0926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9dr1tpJcUuCADnwnAhMFaPJOPqoJVeFtKorNOwnkECx3LeVUZBnNdd2PAYieqI/Vgu3wywpyEOs/7j6Mtz6vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

*** This patch series adds support for AMD PTDMA engine ***

Sanjay R Mehta (4):
  dma: Add PTDMA Engine driver support
  dma: Support for multiple PTDMA
  dmaengine: Register as a DMA resource
  dmaengine: Add debugfs entries for PTDMA information

 MAINTAINERS                         |   6 +
 drivers/dma/Kconfig                 |   2 +
 drivers/dma/Makefile                |   1 +
 drivers/dma/ptdma/Kconfig           |   8 +
 drivers/dma/ptdma/Makefile          |  12 +
 drivers/dma/ptdma/ptdma-debugfs.c   | 249 +++++++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 445 +++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 700 ++++++++++++++++++++++++++++++++=
++++
 drivers/dma/ptdma/ptdma-ops.c       | 464 ++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 244 +++++++++++++
 drivers/dma/ptdma/ptdma.h           | 563 +++++++++++++++++++++++++++++
 11 files changed, 2694 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-ops.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

--=20
2.7.4

