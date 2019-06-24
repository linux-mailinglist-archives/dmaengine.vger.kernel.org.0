Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1B51ABB
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfFXSfE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 14:35:04 -0400
Received: from mail-eopbgr720053.outbound.protection.outlook.com ([40.107.72.53]:24415
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbfFXSfE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jun 2019 14:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj0bzWf6+MqDUIlV4j65618yeg8AuS9uKU1xg74asGY=;
 b=LKeDx3yUBqL/xCge91iXKV47RuhIVINBSJ6xdv4Zn7bL1bRBy2r5IEpzKq5xf5sPlE9MiO4L5qo8JP6/WMwTyyfzK2zvj2n8r0EXsAqYbEZMxvdG+/RwmS+GTbeUTnKuVJ44ko6QPzL3dCHYjQeM+D5bYNdHuW7S5f1VCJYPV4I=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1417.namprd12.prod.outlook.com (10.168.236.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 18:35:02 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::180c:ff0c:37e6:a482]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::180c:ff0c:37e6:a482%10]) with mapi id 15.20.2008.014; Mon, 24 Jun
 2019 18:35:01 +0000
From:   "Hook, Gary" <Gary.Hook@amd.com>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH] Documentation: dmaengine: clean up description of dmatest
 usage
Thread-Topic: [PATCH] Documentation: dmaengine: clean up description of
 dmatest usage
Thread-Index: AQHVKruIc2Kes2M1zUyEVecbjL+xhw==
Date:   Mon, 24 Jun 2019 18:35:01 +0000
Message-ID: <156140130017.28986.2649022716558702933.stgit@taos>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:805:3e::27) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07fced30-17e7-4aeb-0205-08d6f8d2ab0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1417;
x-ms-traffictypediagnostic: DM5PR12MB1417:
x-microsoft-antispam-prvs: <DM5PR12MB1417B15D4494F7ADCCA0C91BFDE00@DM5PR12MB1417.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(7916004)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(14444005)(71200400001)(26005)(110136005)(102836004)(2906002)(6436002)(33716001)(52116002)(103116003)(316002)(6506007)(386003)(478600001)(66066001)(6486002)(3846002)(53936002)(7736002)(305945005)(14454004)(72206003)(81166006)(8676002)(9686003)(6512007)(8936002)(81156014)(2501003)(25786009)(256004)(66946007)(68736007)(186003)(99286004)(486006)(6116002)(66446008)(66556008)(64756008)(73956011)(476003)(66476007)(5660300002)(71190400001)(2201001)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1417;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NUpuVrYt0hfSsKRIizNKyGhiJKOP0Z4i9OgA+ncLdLCppKlwEjCOoGuQ83RPkWBMC+KU/eGLQBZ+6veUTIRHbLZoo//ZrSHZav87kv2yYpyvRACu3cC4LmaVfLPAFhimYG+gsZUxzE5jBh4R7iiFEJGL+Uq9YMLG7i8O1uB1iuEKrSqX6vXZU8g0Yzd56QGrtDUvAh0Jc3fiSlkanZs/lwtNnl+imjD2SVCWDLvX6vTueJNfWfzGwrEW6YWnr8Lr9df6o0H5Bj7DklIPiFoePBbOq/oOVuNljiVTA19H5gpqCEcRexTVsGZExzcnZ+IPedadSz7cPICx8QHTBe5VPlseqAMZ7pi93zBAQ64wjhXleSbQraf2nN25wwMSQt0bo7wP+KIcVYthbgsuCFwMGxxbSsBXr3KYogJrDFfYfKA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A877A8A46A07AA4F8828F839A97E0538@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fced30-17e7-4aeb-0205-08d6f8d2ab0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 18:35:01.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghook@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1417
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix the formatting of the multi-channel test usage example. Call out
the note about parameter ordering and add detail on the settings of
parameters for the new version of dmatest.

Fixes: f80f9988a26d7 ("dmaengine: Documentation: Add documentation for mult=
i chan testing")

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 Documentation/driver-api/dmaengine/dmatest.rst |   21 +++++++++++++-------=
-
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation=
/driver-api/dmaengine/dmatest.rst
index e78d070bb468..ee268d445d38 100644
--- a/Documentation/driver-api/dmaengine/dmatest.rst
+++ b/Documentation/driver-api/dmaengine/dmatest.rst
@@ -44,7 +44,8 @@ Example of usage::
=20
     dmatest.timeout=3D2000 dmatest.iterations=3D1 dmatest.channel=3Ddma0ch=
an0 dmatest.run=3D1
=20
-Example of multi-channel test usage:
+Example of multi-channel test usage (new in the 5.0 kernel)::
+
     % modprobe dmatest
     % echo 2000 > /sys/module/dmatest/parameters/timeout
     % echo 1 > /sys/module/dmatest/parameters/iterations
@@ -53,15 +54,18 @@ Example of multi-channel test usage:
     % echo dma0chan2 > /sys/module/dmatest/parameters/channel
     % echo 1 > /sys/module/dmatest/parameters/run
=20
-Note: the channel parameter should always be the last parameter set prior =
to
-running the test (setting run=3D1), this is because upon setting the chann=
el
-parameter, that specific channel is requested using the dmaengine and a th=
read
-is created with the existing parameters. This thread is set as pending
-and will be executed once run is set to 1. Any parameters set after the th=
read
-is created are not applied.
+.. note::
+  For all tests, starting in the 5.0 kernel, either single- or multi-chann=
el,
+  the channel parameter(s) must be set after all other parameters. It is a=
t
+  that time that the existing parameter values are acquired for use by the
+  thread(s). All other parameters are shared. Therefore, if changes are ma=
de
+  to any of the other parameters, and an additional channel specified, the
+  (shared) parameters used for all threads will use the new values.
+  After the channels are specified, each thread is set as pending. All thr=
eads
+  begin execution when the run parameter is set to 1.
=20
 .. hint::
-  available channel list could be extracted by running the following comma=
nd::
+  A list of available channels can be found by running the following comma=
nd::
=20
     % ls -1 /sys/class/dma/
=20
@@ -204,6 +208,7 @@ Releasing Channels
 Channels can be freed by setting run to 0.
=20
 Example::
+
     % echo dma0chan1 > /sys/module/dmatest/parameters/channel
     dmatest: Added 1 threads using dma0chan1
     % cat /sys/class/dma/dma0chan1/in_use

