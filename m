Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255E9B1CB2
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2019 13:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfIMLzT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Sep 2019 07:55:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:39544 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729497AbfIMLzT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Sep 2019 07:55:19 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DBqsH0009487;
        Fri, 13 Sep 2019 07:54:12 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2059.outbound.protection.outlook.com [104.47.34.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1hhjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 07:54:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doVIlqVN3xuSOsU5cvqD7lv/Zh0YEGhXql4LA/ZlbzClU0UKMIcIrr/jrk/vg/CylAKqwSaJEmzrlsPOpVoWXQup1e3yRtcdLK9+FdXhUH9oe0gc+qJ2KqAngaR4tCAfvKhsYORASHTDmWecAJiu79L82L9Bh8KK1X4hwWkCA6seBF9w2yyad/zW77KTwiyk1z3qKi3FMa5W70FaOvKPcH5wIem33MK/bevW1P+NobA5s6F+pIXbmJD62Z6tXgLkUooIENFVGLKjLVrbOC6syfYsHaicG3lbYaysgW2YiO/6TrKrBQ77Tfx9pL5EriHhgh+iY3PVX57JAK8yWDxN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxkSVdHGqrHyDid8NKBggxJxI+u5Fv8wsgt5rZUXG+8=;
 b=Rwq19Y4cQB8nwdyzq75Wb/5WrSgAFZ+v/2+5gOZkJaGJl4AT+iYuvwdZAOog6sN5feqZTmN2xhMcA9QjZdBFskOG3d2kyMydUJVksHn8fz7KAhStai5bzSIVpdtSKPtkHmywiHhCwuePqRH6cB4DZD52UifIgEohM0n71aERn3glP3BwS8bFDlxMteO3bFBLTP6EePwaHT8+guNKxBuwHroALvq/XcgNYirAwUP3S9EwB3h239rCJsrkEWRRODiA/nPYlEcPlCgqR5/g0BOCtYyB/QDEOIlek1P2d+0kjCxCUig3Q20atPdMJhHK5olpmkphfqgMmmCeQ2iAl8Ahww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxkSVdHGqrHyDid8NKBggxJxI+u5Fv8wsgt5rZUXG+8=;
 b=ewiEfGzlLRNdeOuYwIyzfs5vQ8NiQsJYmuyDlIhEbYtGLsH/LLsLGycM6fopMv3wtxDkLEaFdbxnixJEgM2UAlAco7fyXIoaxeXbXPrccYexJ/cfEduW9xEe0G8JfXWqdKtckDu1V1hRN/N4jk0gZKXuWda8BND+cpAtd85GlVA=
Received: from BN6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:404:4c::28)
 by BYAPR03MB3927.namprd03.prod.outlook.com (2603:10b6:a03:62::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13; Fri, 13 Sep
 2019 11:54:10 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR03CA0066.outlook.office365.com
 (2603:10b6:404:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.13 via Frontend
 Transport; Fri, 13 Sep 2019 11:54:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 11:54:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8DBs27g005229
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 04:54:02 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 07:54:07 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>,
        Rodrigo Alencar <alencar.fmce@imbel.gov.br>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] dmaengine: axi-dmac: simple device_config operation implemented
Date:   Fri, 13 Sep 2019 17:54:04 +0300
Message-ID: <20190913145404.28715-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(336012)(6666004)(4326008)(51416003)(7696005)(186003)(107886003)(36756003)(106002)(426003)(8676002)(316002)(8936002)(54906003)(1076003)(110136005)(48376002)(50466002)(50226002)(47776003)(356004)(86362001)(70586007)(7636002)(5660300002)(126002)(2616005)(476003)(246002)(70206006)(486006)(305945005)(44832011)(2870700001)(26005)(2906002)(14444005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3927;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35b99c7e-d0e1-4400-15b0-08d73841166a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR03MB3927;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3927:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3927BB5C48F6F3C9CED637F0F9B30@BYAPR03MB3927.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ITxexAT51/T6EUr5E2l+IvbNv+5TcbC3ZVtnUNjUFaSEG9dOrk2feaZ4XnW8NHDZrh3VWFBoexed8HwXBfk5UT3DOFDULnaLtFrcJAHHr30Za8Jyrt+OvjqFHOPoVtjjOcfsj0F2CwtGOtZuND6kWlNYrn4hP8MCG60fRHe3Pw4idNadvl8g0fQg5IieZMfHZQkIK5xLDIieUieGfz0ihaKFgyoeRzUuPW0HzBylI9seVPsWjhWMo+g182Sc0lIv5jIpld2cN8n8acstJa7JQtCiD6SGTVV9p2CtjexEGFAx5amql4zGAOyqMAjPdm769ZT5Nfoz1fEfALsxHfQwUt/ATyC0+5JJB1qmzH/9LSmatrkgvd+AHR74VB2BaHoszahjZEIhZMQ5PWhD7w3vRoWIc23s1szJnP902QZ1Rhc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 11:54:09.5164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b99c7e-d0e1-4400-15b0-08d73841166a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3927
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_06:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=9 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130116
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Rodrigo Alencar <alencar.fmce@imbel.gov.br>

dmaengine_slave_config is called by dmaengine_pcm_hw_params when using
axi-i2s with axi-dmac. If device_config is NULL, -ENOSYS  is returned,
which breaks the snd_pcm_hw_params function.
This is a fix for the error:

$ aplay -D plughw:ADAU1761 /usr/share/sounds/alsa/Front_Center.wav
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
axi-i2s 43c20000.axi-i2s: ASoC: 43c20000.axi-i2s hw params failed: -38
aplay: set_params:1403: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 48000
PERIOD_TIME: 125000
PERIOD_SIZE: 6000
PERIOD_BYTES: 12000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 24000
BUFFER_BYTES: 48000
TICK_TIME: 0

Signed-off-by: Rodrigo Alencar <alencar.fmce@imbel.gov.br>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Note: Fixes tag not added intentionally.

 drivers/dma/dma-axi-dmac.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index a0ee404b736e..ab2677343202 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -564,6 +564,21 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
+static int axi_dmac_device_config(struct dma_chan *c,
+			struct dma_slave_config *slave_config)
+{
+	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
+	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
+
+	/* no configuration required, a sanity check is done instead */
+	if (slave_config->direction != chan->direction) {
+		dev_err(dmac->dma_dev.dev, "Direction not supported by this DMA Channel");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
 	struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
@@ -878,6 +893,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_tx_status = dma_cookie_status;
 	dma_dev->device_issue_pending = axi_dmac_issue_pending;
 	dma_dev->device_prep_slave_sg = axi_dmac_prep_slave_sg;
+	dma_dev->device_config = axi_dmac_device_config;
 	dma_dev->device_prep_dma_cyclic = axi_dmac_prep_dma_cyclic;
 	dma_dev->device_prep_interleaved_dma = axi_dmac_prep_interleaved;
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
-- 
2.20.1

