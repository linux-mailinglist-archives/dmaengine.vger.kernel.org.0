Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE384426313
	for <lists+dmaengine@lfdr.de>; Fri,  8 Oct 2021 05:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhJHDf7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 23:35:59 -0400
Received: from mail-eopbgr1320099.outbound.protection.outlook.com ([40.107.132.99]:38816
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229634AbhJHDf7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Oct 2021 23:35:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCJE2uP3ZgWsdHexX6WLnZqguuccF8IjAcVsG0W+ypl7QQ+06VwCwGdtlOqvJKh9o//fvttsLKj3PXlJ8Hl7ACmCUSI2CRxN1dFSc26fyPhfHcqpHtSHL83Cts1qdqi4jJH/NvEo8Nv9VLalwoSppn3lkEgX2aFuzYk4YSM2eEtj6v8MMUzdnaKPOPfWLAA8ksEFKxE10ohi5T+2STBDAaxN25N1MxKkN9O7ctOQnhMyjJgB7EXy2P/TBRjTVqHTHssY/zobhXyIfwOMi/SRSm3chihr1iCHAfdOEv03yklXBt2I/U/UYf/fN3+m4SOMECPAV3wyHzWbQTd8JVdcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BqDuETXubrgrVWn5JxjfU9r6IQhgCl3M5H4w5mbj44=;
 b=PXn6WCCsbyr+jlEcJkddpwDJJ/+jTxO0tIH5Unf+ytn2YMsmiHMuczGaosS7GikgerdS7pqn4uH/oHXJwxUjyEuZytnXjvHHpigtk77jcunE1hAstj+cSmt/J1+jedVZHR7ZXk3EH8lIdl3Ig4NEL73G7gHwZWQv61RkHu2mnim2iBmm8im05RWI38hVkKhGDtmdWzCaVBgWyIQF1lZg4DwXQRBIC3f1GmVGwna+rIzfJmkAtfrvVvBETZ3zlC+pGk7zMGBS+64ABZI+5y/hB5Lj7EIOFd9qE2VzJIYSjNi6hmoJqsdlC9wPkFw7Klk4+O4mOuCVmaIEKeIq8G+qSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BqDuETXubrgrVWn5JxjfU9r6IQhgCl3M5H4w5mbj44=;
 b=np7tGxVWcm+AgcZiYni4YuMwVP/2YfF6TigSsaY9MPYKloRxIcRqjmPk73eOmON2J2wgvWsl4QIvTG/bFbtG6HMEC/dCxNYt1t+lNRJNPN35wvyVYkeZI4K2OSZwnw1ZDNwqPLJ7ezDVvgCaQr/UBiv/3p8t+ihbcY1UV+xyN3Q=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3115.apcprd06.prod.outlook.com (2603:1096:100:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 03:34:02 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 03:34:02 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V3 7/7] message: fusion: switch from 'pci_' to 'dma_' API
Date:   Thu,  7 Oct 2021 20:28:33 -0700
Message-Id: <1633663733-47199-8-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
References: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 03:34:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 943ca56f-132f-4d9c-5603-08d98a0c7916
X-MS-TrafficTypeDiagnostic: SL2PR06MB3115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB31157DD423C3137AF478936DBDB29@SL2PR06MB3115.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOmaNS971rwUTGp46OIQUYXdSQUmgYmW27yD+L8T77D5HWGz6uA/kildnODQDz+cC9mcUkassEJZ7CE2qrBEPugJGFGQJoF2FZe+yifOTCza3okrfQR4ODa7wZdtotYl3GCwgbRCoaapNukbh0kpIKt0Rg+vKdbZ+ohG54oDQAHec8/vck8qLMQXHze2hkjNNsKCLGOzXFzvfoY4nXQzoDC3E8uqF2CQXLQmLwQ9vTI7ZuzInudBPnyb96xnKE8DiI4+0wvuHX1J410BSYodd6ZZbYTmEgh0XMIBkVYRmFN3v4FfVYTIkJJdHBtSL6TRA71lJCy5LZk2zH/1faMzbAKZzApuF3FH3yJp3IH+l/a+BkarggveqHQnM05FMPeApQerB3Qb+l8qcY/pkRJk5Yocetk/RmbqWuy03+zWNEUJr68ddZvf7Nl/qju7oaAAKuDf/BNsEM/KL9NnoBNKFwhYqNBi6jaljZq74A4klvj6wSHtomaV4S194N+LEuRzEvZp0Il/piG8fSCKLSUwagR2zGt+ERDLGVp/GZbV/99kasmicntM/VeWZu/aGDplErai+bNDAxA2lzJid0mPbIxoU8eMA/kazdssNQXo9WNwS0uwG+abHJPTVYa2E+3Z51g5yc+qqAJ3z/QCztGUalgfwIJpWLAhxpDRUbBUBtwU2lEA6NTCIcCmfmUHLpQE/wdfsQQ0GhyJouTGYRXjdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(38350700002)(8676002)(38100700002)(110136005)(921005)(83380400001)(107886003)(86362001)(956004)(2616005)(7416002)(6666004)(316002)(4326008)(15650500001)(2906002)(36756003)(66946007)(6486002)(66476007)(508600001)(6506007)(52116002)(66556008)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EIWogR6CKto7uBL8CY9zO4DiTYI95Wwk4y5DdVod3l+9wAUWTDTpbRQsvX+5?=
 =?us-ascii?Q?4N+CSXdj5+sXOnqPjtfGqbHH1Q+o9jHWP6OvAeSoy9UWnmnMkfVgUFFCPRnD?=
 =?us-ascii?Q?Eu0IzIcyX3WJrKEJSLX2QYC7TN7qtEo1AeV+/1vo+6YxqM2jqVbCULnpkYPc?=
 =?us-ascii?Q?rbQDfY1gtATfKmIhIFm1X1qy/TrIVlY9bqmwYVonJgmwMS3Q6Bw6QDyZB6AU?=
 =?us-ascii?Q?/a+uMfJENHx9LcJCcFyS/aVPfSJQyiLNTsIHRri5sWEuromdElBOpGVIS4zN?=
 =?us-ascii?Q?cAkM7KPC+eqZ/gCMnZunTOWhzhg+dL65cFoU7eY80WnEcO472H4GMKIq6EvF?=
 =?us-ascii?Q?j9dOTGBwFJw2pszLvocqQSBL5/mXszWDUN2Zmfh5kNXcgRTWMa2pEDkLLjR1?=
 =?us-ascii?Q?BP6disnrtkDH4oFFYWjgoz24TxhNF3I5Y9hLA5wu/3wJ1RdfpBYFopKf6KnV?=
 =?us-ascii?Q?yRKgp5E76wyZqqf5QMUOfRCPrwGizY/UsCP4F5v2Mk3pgjT4UVrGDcyzeTrt?=
 =?us-ascii?Q?qm1Ro4sdb2MTa/YnkCueYZMYnH7fLEwwSQohG+80HJuUXus5vDfPKyfRf9kf?=
 =?us-ascii?Q?vvjlIVMM9LgZXZik7g77vReq7Ji9YSkVDgeKoG+CGN3OO3RSSmsX4OJ0t2mY?=
 =?us-ascii?Q?wv2h/wQtIpDkfkkEJIzv3vJNISKmtWJ4FA/I2HUPbfSQsaFcz5k4Zm5Ms9bk?=
 =?us-ascii?Q?PTGuDMorSK7+D04HRMNzQWzRyLZpuHBTyt22NE2XYNlMmKH7SQFi6wY4Okd0?=
 =?us-ascii?Q?Lumy/ne+o8E5gBgOuA/SRvlMmbmQ4mLAFh/hw6EWtSEC+wlHsfNiuzmJnKRL?=
 =?us-ascii?Q?pmD6DOlrOxT5YoDtCOoNFK/JNKd6+1FszcLnES25lM/iizFy8R49qUWLSsaR?=
 =?us-ascii?Q?f/5nrbmxgnCUWtAEssdiA0HvH84c4jLkVVE/+qNDagBWs0Z7FRNU7/2Iikqe?=
 =?us-ascii?Q?8fjFW+BGvq9OZ3kmspaucVARut/gOwP6wHKlHYvkdp+6pyFeVXkYx0EqBLc0?=
 =?us-ascii?Q?K3UAxnPoB9E48USgbe5jpg4smi5QMtuTZFoRINOWXLG4WeMJVFKrF9w3PngS?=
 =?us-ascii?Q?GRzJlq7Dw5c1WR/KJESb+ochXwE7+4DpMhAqbazoNEKx7i4Ka2YKUb5PA3vo?=
 =?us-ascii?Q?2WEFRFW7U8+WAFAHQTz2a/KkXmYFUDg3ZsvdvbnREQcfTbZjHWOeVzEa1BNe?=
 =?us-ascii?Q?yp42FvM5rF9CSpkU7gK0C/DyBPEpH5YK3/v6iOIk8714x+gK90YKeFTEqYJj?=
 =?us-ascii?Q?c2LR4yM0l9sP9HloJr+hGJN1L1Ymg/sI9lHHYHgxRWqO8FrHmPKpPnbcwPJ7?=
 =?us-ascii?Q?3gORF2Yj6+weOV+ltOn0AFAv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ca56f-132f-4d9c-5603-08d98a0c7916
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:34:02.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHLD09XPvIjQ+WaIdoOSsjADthtUoq0j/cFjdn9EGhs2ELuqPNQNMEJ8/2HQF//b8UZ/306sZkC8WCfuEzFONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3115
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

pci_set_dma_mask()/pci_set_consistent_dma_mask() should be
replaced with dma_set_mask()/dma_set_coherent_mask(), 
and use dma_set_mask_and_coherent() for both.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/message/fusion/mptbase.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 7f7abc9..c255d8a
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1666,16 +1666,12 @@ mpt_mapresources(MPT_ADAPTER *ioc)
 		const uint64_t required_mask = dma_get_required_mask
 		    (&pdev->dev);
 		if (required_mask > DMA_BIT_MASK(32)
-			&& !pci_set_dma_mask(pdev, DMA_BIT_MASK(64))
-			&& !pci_set_consistent_dma_mask(pdev,
-						 DMA_BIT_MASK(64))) {
+			&& dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
 			ioc->dma_mask = DMA_BIT_MASK(64);
 			dinitprintk(ioc, printk(MYIOC_s_INFO_FMT
 				": 64 BIT PCI BUS DMA ADDRESSING SUPPORTED\n",
 				ioc->name));
-		} else if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(32))
-			&& !pci_set_consistent_dma_mask(pdev,
-						DMA_BIT_MASK(32))) {
+		} else if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
 			ioc->dma_mask = DMA_BIT_MASK(32);
 			dinitprintk(ioc, printk(MYIOC_s_INFO_FMT
 				": 32 BIT PCI BUS DMA ADDRESSING SUPPORTED\n",
@@ -1686,9 +1682,7 @@ mpt_mapresources(MPT_ADAPTER *ioc)
 			goto out_pci_release_region;
 		}
 	} else {
-		if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(32))
-			&& !pci_set_consistent_dma_mask(pdev,
-						DMA_BIT_MASK(32))) {
+		if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
 			ioc->dma_mask = DMA_BIT_MASK(32);
 			dinitprintk(ioc, printk(MYIOC_s_INFO_FMT
 				": 32 BIT PCI BUS DMA ADDRESSING SUPPORTED\n",
@@ -4452,9 +4446,7 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		 */
 		if (ioc->pcidev->device == MPI_MANUFACTPAGE_DEVID_SAS1078 &&
 		    ioc->dma_mask > DMA_BIT_MASK(35)) {
-			if (!pci_set_dma_mask(ioc->pcidev, DMA_BIT_MASK(32))
-			    && !pci_set_consistent_dma_mask(ioc->pcidev,
-			    DMA_BIT_MASK(32))) {
+			if (!dma_set_mask_and_coherent(&ioc->pcidev, DMA_BIT_MASK(32))) {
 				dma_mask = DMA_BIT_MASK(35);
 				d36memprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 				    "setting 35 bit addressing for "
@@ -4462,10 +4454,7 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 				    ioc->name));
 			} else {
 				/*Reseting DMA mask to 64 bit*/
-				pci_set_dma_mask(ioc->pcidev,
-					DMA_BIT_MASK(64));
-				pci_set_consistent_dma_mask(ioc->pcidev,
-					DMA_BIT_MASK(64));
+				dma_set_mask_and_coherent(&ioc->pcidev, DMA_BIT_MASK(64));
 
 				printk(MYIOC_s_ERR_FMT
 				    "failed setting 35 bit addressing for "
@@ -4600,9 +4589,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		alloc_dma += ioc->reply_sz;
 	}
 
-	if (dma_mask == DMA_BIT_MASK(35) && !pci_set_dma_mask(ioc->pcidev,
-	    ioc->dma_mask) && !pci_set_consistent_dma_mask(ioc->pcidev,
-	    ioc->dma_mask))
+	if (dma_mask == DMA_BIT_MASK(35) &&
+	    !dma_set_mask_and_coherent(&ioc->pcidev, ioc->dma_mask))
 		d36memprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 		    "restoring 64 bit addressing\n", ioc->name));
 
@@ -4625,9 +4613,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		ioc->sense_buf_pool = NULL;
 	}
 
-	if (dma_mask == DMA_BIT_MASK(35) && !pci_set_dma_mask(ioc->pcidev,
-	    DMA_BIT_MASK(64)) && !pci_set_consistent_dma_mask(ioc->pcidev,
-	    DMA_BIT_MASK(64)))
+	if (dma_mask == DMA_BIT_MASK(35) &&
+	    !dma_set_mask_and_coherent(&ioc->pcidev, DMA_BIT_MASK(64)))
 		d36memprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 		    "restoring 64 bit addressing\n", ioc->name));
 
-- 
2.7.4

