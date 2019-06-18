Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8D4AD99
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 00:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfFRWDO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 18:03:14 -0400
Received: from mail-eopbgr700075.outbound.protection.outlook.com ([40.107.70.75]:54785
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730301AbfFRWDO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Jun 2019 18:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tIqnb0xSLpG4prfLnuuJC9S1+byft/BgU3/2cdeb2I=;
 b=JT6f8lrjqJPE8m84fMoIacoPWDUo1xAZT1KkSkTWOpx1iyCYdWXzUuc599pIHmnjAAoMD31cNChvb5bO3aGMxP/+XG+JXf2g35vLJrIltKTpXuW16uwXJlWLTQymysxRCvXekA/7uOA7OK436giqTlTzgiL6LMVUVKc5fo/Kn/E=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1707.namprd12.prod.outlook.com (10.175.86.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 22:03:05 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::34ed:dc98:e87d:50c4]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::34ed:dc98:e87d:50c4%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 22:03:05 +0000
From:   "Hook, Gary" <Gary.Hook@amd.com>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dmaengine: dmatest: timeout value of -1 should specify
 infinite wait
Thread-Topic: [PATCH v2] dmaengine: dmatest: timeout value of -1 should
 specify infinite wait
Thread-Index: AQHVJiGaU+h52VIstkGzsXq6WB9IFw==
Date:   Tue, 18 Jun 2019 22:03:04 +0000
Message-ID: <156089501718.8121.12070116684408969349.stgit@taos>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR1401CA0006.namprd14.prod.outlook.com
 (2603:10b6:4:4a::16) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfd88940-3b1c-440e-c3c5-08d6f438bcfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1707;
x-ms-traffictypediagnostic: DM5PR12MB1707:
x-microsoft-antispam-prvs: <DM5PR12MB17076DC46214A87E46216B0FFDEA0@DM5PR12MB1707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(68736007)(2501003)(6486002)(81156014)(5660300002)(81166006)(7736002)(305945005)(99286004)(72206003)(102836004)(64756008)(6506007)(66946007)(66446008)(8676002)(478600001)(71200400001)(6116002)(3846002)(14454004)(33716001)(386003)(71190400001)(103116003)(66476007)(66556008)(256004)(316002)(2906002)(110136005)(6436002)(9686003)(6512007)(486006)(8936002)(476003)(86362001)(25786009)(53936002)(73956011)(26005)(186003)(52116002)(66066001)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1707;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 49c6rRmEmDvqfOSTj2FXRDqSziAxivwWfX754WHROSEhaMHSHCZ+9DkKKAVXAIM3+CLBv7SwL9WbayGLl+9+HTqOC2sCJ27aeG9usA1+IUsRjmxyrFIyFjRAhyeQWC6lPXV85ehhdXRVT4SDbmmkwirP4CA0oxKt6SEUw27Ddj4QYD50M+U3bduKiZ6c3O6AmZ509ijuZLL5Eb6pmY4LzzoPopM+yG0neeeQm5xrMmXu0pUOJirRDZrWKyQl2Hlun83SeAG70j6+x4vmNTVVPjPbchpf20edGdF5Mty+J1qNcFqBdje+U8d0nVmPUPLgrKJktvIXAtxUDJjWPIgN5SNDJGUvXUZV8cVAv+JCZqxSLFR29d8Qk136lRptD0AC7KqfPjlwkkUr9RPMX0pisEdZ1QGnN+3j/OWNXQmIqe4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <222D7D8F7DA46E4B8F00B712C9AAE5D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd88940-3b1c-440e-c3c5-08d6f438bcfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 22:03:04.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghook@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dmatest module parameter 'timeout' is documented as accepting a
-1 to mean "infinite timeout". Howver, an infinite timeout is not
advised, nor possible since the module parameter is an unsigned int,
which won't accept a negative value. Change the parameter
comment to reflect current behavior, which allows values from 0 up to
4294967295 (0xFFFFFFFF).

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/dma/dmatest.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index b96814a7dceb..e0c229aa1353 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -65,7 +65,7 @@ MODULE_PARM_DESC(pq_sources,
 static int timeout =3D 3000;
 module_param(timeout, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(timeout, "Transfer Timeout in msec (default: 3000), "
-		 "Pass -1 for infinite timeout");
+		 "Pass 0xFFFFFFFF (4294967295) for maximum timeout");
=20
 static bool noverify;
 module_param(noverify, bool, S_IRUGO | S_IWUSR);
@@ -97,7 +97,7 @@ MODULE_PARM_DESC(transfer_size, "Optional custom transfer=
 size in bytes (default
  * @iterations:		iterations before stopping test
  * @xor_sources:	number of xor source buffers
  * @pq_sources:		number of p+q source buffers
- * @timeout:		transfer timeout in msec, -1 for infinite timeout
+ * @timeout:		transfer timeout in msec, 0 - 0xFFFFFFFF (4294967295)
  */
 struct dmatest_params {
 	unsigned int	buf_size;
@@ -108,7 +108,7 @@ struct dmatest_params {
 	unsigned int	iterations;
 	unsigned int	xor_sources;
 	unsigned int	pq_sources;
-	int		timeout;
+	unsigned int	timeout;
 	bool		noverify;
 	bool		norandom;
 	int		alignment;

