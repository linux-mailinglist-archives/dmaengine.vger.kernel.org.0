Return-Path: <dmaengine+bounces-1683-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C02AB894466
	for <lists+dmaengine@lfdr.de>; Mon,  1 Apr 2024 19:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D692829AC
	for <lists+dmaengine@lfdr.de>; Mon,  1 Apr 2024 17:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC2E4D135;
	Mon,  1 Apr 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VkO5qbtT"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2098.outbound.protection.outlook.com [40.107.249.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FC3FE55;
	Mon,  1 Apr 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993342; cv=fail; b=TnfW8WiSaEDPL7VxX/bryA0jpTXoHDBhSJqHlsPt6hMVz8pTeN/z2jDWA4a6ewGUBoMx0SeT512FPurnL+Mq2rGuAKZYqD0jHE24lmXeBNaamRvjv/oUNedLAHELCICRo0C729zwuprMMGeLxuzwskUST83HT+7eL+sV2kneKoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993342; c=relaxed/simple;
	bh=yUw1i+Qg1bKYG9dlRVK30DS3m9WdMEqGrsLgdbn5d30=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GN83yTHoNp8BcDu1AJiy2Tw762kxwY5jzxKDegkL8j9aVF54vvvw0a1OvL1JjidBQX4lRg6YUA6lK65aIh7bs6AlMq/OGlqi9fjIf8aT3mFdp2pyYeqCmejCBAI5wltY2n6AkQW6KdXcU2eSkQBisWh05BurpEm3lwqV49WAnnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VkO5qbtT; arc=fail smtp.client-ip=40.107.249.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbK0Jpc1IQXHoI5apNNqY8p5pWGEnYYyWk2nZmL0ewZa+1Y+b97mwYg87mJIDSmTCCr6+1KaCRHlZn2fLpDYR343aNrOfhO01tjpGdbdsFboroq3zGH2/LqVuDKAzPbZJsQpolmlSKboiJBbS8BNeN0Kpqzsd33OIquinNgAVcVr6kVWzC7EKFpleQOPNuOmlRXmnuQthMjEQM9k1AA3ppZeE3QFZZBCmctmiFGBsLjZkB2dYqymiXtNwOag/QnQiArpIqgm4AaM9nXn0mUNgHUk1NAqhf0dWFGaI6R4S9rxM2fR5c1DFjB9mSQCAq3loWUcZgJfzvoBEqzdngVF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCuL3SUrmC0AZwVY++sQ7JSSOGlDwwqqFRgsih4XiLM=;
 b=lsaKBy/wsKzdhSYlDQJYeouCtJWvZ0F1KwPhqYjEY6vlQ0eHE5N66ZS6wS5qq+JRbxbe+sRmd/LF29XnW2uRg+fQDwrYsHkbUx3OELvhKgS+dzH5oIF9u4VVJM38wkSrdX4FwKMtL78mEghSZ0zJKmcnCtGT3zSLvNFHYisGEMUIuoOyBnIyNam8vWE4VTxxdqeB3KNHTj2mw2xj9l+CL5HfzpGv5Gx0Ug9YJg9p46Dx3qYWuyprI1xwDKB58LS2rG/y/vC4H7Bpg2Qf9zX5/71b4j+lZQaK3npyP6M9Bph2QE0YoldZ2XQRapGj9VHiPr0OHTbjMxPrY6UIH8rrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCuL3SUrmC0AZwVY++sQ7JSSOGlDwwqqFRgsih4XiLM=;
 b=VkO5qbtTB02E6wi53ItyhdJjouNz83UC33k8aXUyr5fBIOuoEL55zJZDi/6NHCWEl580tXqlBO14ZKvX/uVWWFDo6KNv7Z7WNCmI8nUKlcENJEqnKXK/DSHpzuy9hq5UqTudRCyrUleVB0uEV+rdFRa7o51UpjmTr1mUUUcMq1E=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8398.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 17:42:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 17:42:17 +0000
From: Frank Li <Frank.Li@nxp.com>
To: rdunlap@infradead.org,
	hch@infradead.org
Cc: Frank.Li@nxp.com,
	corbet@lwn.net,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lizhijian@fujitsu.com,
	mst@redhat.com
Subject: [PATCH v2 1/1] docs: dma: correct dma_set_mask() sample code
Date: Mon,  1 Apr 2024 13:41:59 -0400
Message-Id: <20240401174159.642998-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8398:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vjGX+a6J0ag06c7Hc1X6MWvpbhJEEyDcrcZcjjQFZmwxIoHkQP50jhHpUd60aGvwyWMNYt5nhbE0mAUYrDukdR9Fjlfd2eaxGAFlMsm+HZWqa9Gv6BxuABJ/wzfxWGMAzwIlWOnodHjT6026vsARdHnwYpe96JJEZLlvYM5iALWlXLMTFEp41uJAWBEtWg8wkgnhKXJbjfLojLfVpUUX6Xk0jlNW6mot5x8dPJ6TJmWprFEm3HJllqM6XQCdXZVVGTWqT9FII7pYXJo+L6myuiwekODvSrvO5IoToDtUmrEgMg8fm+UQeJxQcIvLr1nh8nyswhIEbn3KdFsiNaaMYleEWK9PmOdzYKqIPv2OK6Rv8hJ5ncV47PzFHQwrVXf8fqY9ZwiGfXYwqKQXm+tROAsr2Js1VSNJvcEL3ti+adTwwb84YaPBfU5BuD4YtUrDarcPknzIwJeZ4wZu+Jy3omAY+WCZPjTTYCkgWHeii1DUks7yGO/IaYDnfYFHlzG59WyKApt5DeGIZXN0yAmq/1oiQ8qGhf6OoksDhwDm/PeIhAuirYPbRjfZCkVlERPmU+4rndBFi6qGUPmdi2Zez1xCkRwaqM477hwbyW+5bTxVI9vxyMHRK9RucJYA5UlTZtn/SpUMJG1FnZ5rtKN2CCtVrv/GVopGzaPJwgd/gwTyNEi9RUh26Y9zrIU8MszXcOifMLeKCcngG5/0RZJ/2zs258sqLD6su/kduk3iKek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xafy3gIFJS4y/PrNThQh9F0iBsMNhw894eqTmp+kd4QagJWlFjFrXBpzmk2A?=
 =?us-ascii?Q?KU04L/lLJhN2ev1ZkREZvZprAdofA9Zted6fnpRz8x2S6uu3UZx5WCh6bQL4?=
 =?us-ascii?Q?NRU1c/n8dOx5iYAAfwCF15DqeBnasV8bYLCxgSPT3UplswwncheJucgFhdt2?=
 =?us-ascii?Q?ECKLyCiLxluaCVbV7fjEiJY0DYhwA5GkoxKiGDKqZInjNKuFK7Awq4RXENwS?=
 =?us-ascii?Q?Y5xHgsPU9Pd6EWIzklrmLGd8Dan8w4umC0pf19LAHc0JFFWseFvC9fAcNiS3?=
 =?us-ascii?Q?rE9Nt6FQSNt0jRFw0buuI31YUTajXxxmOPy9UzuxIHJoWwJXsQq9PYIvu7yY?=
 =?us-ascii?Q?hpzU7a6/Qg2TjuPQEFZRWyGau99SZCuq6MdfmlS9vAUgMoDjmKUdReFcgOf6?=
 =?us-ascii?Q?6+S/WvkOC7LEW0nRSQK1+QB8OtFXcFIKSwFBRWA1iYHbN6/RJSAJ46ZvMRdX?=
 =?us-ascii?Q?b+eV/gnUum0f0f4QBGvtyaKRC1GOdH7NjfXFkrp3k/179NXJQ0DzLYB1yScs?=
 =?us-ascii?Q?ZtrIsE0r/U+pid1yiijeQE0BpnNg46l75b+n84z3eA/k71fuOnrrI3PQZ3KN?=
 =?us-ascii?Q?UatSlDKwi+X5FDRmVYNRsJNQx1FVmYuWkehtkdZLuk6wJqqDpFvz6nNVdxmn?=
 =?us-ascii?Q?1wyVhuMKF2XBHKXlxYSITBx2w+awZvZ4ZKvDzVf5uP1KBc9itMCASXJq2sO9?=
 =?us-ascii?Q?XpMEnFJ8O7NfMjn2sW9NQhJVXOBrzCEVWgg6DxYJ9ACKvrrKMmWbmpJWIQzD?=
 =?us-ascii?Q?sM9BRb6HuH/Lr/zrJF+uNUNWFZh1+mc6YNafHdTMwNwIUjxhK//KVc18hHVh?=
 =?us-ascii?Q?A8tTQDMKIsvGtYaBPwKHz3G9fb63Fibjq+6naruZf+RQ3XkLZ2dvuSAh8ODo?=
 =?us-ascii?Q?31c8BDBp6JJtb9FXmYIdTfCyDf7+SkwYHoo6Ynk5o5V1V+qYKqhzvvhDvPtf?=
 =?us-ascii?Q?T3g9QF0YoA9WkiN0qBsxvCSId9dYpkn0wbMzXaiSNPl1quMIbc2w1KQIaSCM?=
 =?us-ascii?Q?377ZfMHASHoUs7takrNdhRmUnud/A4ciWdVQSw0bqS9kPYGhF8lbeQnbRsqA?=
 =?us-ascii?Q?vBGvK/v9x2epBJASBvoLcIJEqIvBFyn9idKDrAvadQb/LGUZMa5Im+OdNlMo?=
 =?us-ascii?Q?0FCDPW9qIWl+6/4VDhaPqAuVFfuubV4uD8F8IllzRJrGVURm0RqYhEd8LwXm?=
 =?us-ascii?Q?lC/1nkfzEj+AIqcMAiNZdrWzzgKncN9GBvUHp4v2NXBsOw3t9yHOf9j0vCDQ?=
 =?us-ascii?Q?MEGIs/6/QyhHQm6IjAETx0ZFkDOBECw1vmCbBgpDQcMsN7XEzxkx0E0ZGL2m?=
 =?us-ascii?Q?ChaE+mYGZfrgWpIH776H+LWsrQm3fJOdaJiCxvRFVl37wX5+PmqZ7GJj/aB+?=
 =?us-ascii?Q?cPzxuxS/eyMgDB01jVN/zeiMZYfieGWzliqXYLb8/UXemqNUUUK86b2JYS+T?=
 =?us-ascii?Q?ZsgyHU1NpPc9pfdP35Ti95NTEi087cZS7+cRJ/LbK3gTLb9usjdkkOadcR4y?=
 =?us-ascii?Q?f9AT24kHffA/zaclhXfIAVzRT6FRZQh0oL9aejYxO6p1VIk7UBFqDNy5M0uQ?=
 =?us-ascii?Q?e91JqaIw4b1LG9DNwr5FrB/P87hvQGG8A7SgD2Pv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986ed8c2-89a9-4861-caa4-08dc527312cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 17:42:17.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUfCZDaSu12yqLpc6imfsFY9s/sa1cRDplUn/30/ykxmsD8gncXgD5Mw9WzfPY3gtezel+sH7OeQtLiJvcK89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8398

There are bunch of codes in driver like

       if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
               dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))

Actually it is wrong because if dma_set_mask_and_coherent(64) fails,
dma_set_mask_and_coherent(32) will fail for the same reason.

And dma_set_mask_and_coherent(64) never returns failure.

According to the definition of dma_set_mask(), it indicates the width of
address that device DMA can access. If it can access 64-bit address, it
must access 32-bit address inherently. So only need set biggest address
width.

See below code fragment:

dma_set_mask(mask)
{
	mask = (dma_addr_t)mask;

	if (!dev->dma_mask || !dma_supported(dev, mask))
		return -EIO;

	arch_dma_set_mask(dev, mask);
	*dev->dma_mask = mask;
	return 0;
}

dma_supported() will call dma_direct_supported or iommux's dma_supported
call back function.

int dma_direct_supported(struct device *dev, u64 mask)
{
	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;

	/*
	 * Because 32-bit DMA masks are so common we expect every architecture
	 * to be able to satisfy them - either by not supporting more physical
	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
	 * architecture needs to use an IOMMU instead of the direct mapping.
	 */
	if (mask >= DMA_BIT_MASK(32))
		return 1;

	...
}

The iommux's dma_supported() actually means iommu requires devices's
minimized dma capability.

An example:

static int sba_dma_supported( struct device *dev, u64 mask)()
{
	...
	 * check if mask is >= than the current max IO Virt Address
         * The max IO Virt address will *always* < 30 bits.
         */
        return((int)(mask >= (ioc->ibase - 1 +
                        (ioc->pdir_size / sizeof(u64) * IOVP_SIZE) )));
	...
}

1 means supported. 0 means unsupported.

Correct document to make it more clear and provide correct sample code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2:
    - fixed typo, review by Randy Dunlap

 Documentation/core-api/dma-api-howto.rst | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index e8a55f9d61dbc..5f6a7d86b6bc2 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -203,13 +203,33 @@ setting the DMA mask fails.  In this manner, if a user of your driver reports
 that performance is bad or that the device is not even detected, you can ask
 them for the kernel messages to find out exactly why.
 
-The standard 64-bit addressing device would do something like this::
+The 24-bit addressing device would do something like this::
 
-	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
+	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(24))) {
 		dev_warn(dev, "mydev: No suitable DMA available\n");
 		goto ignore_this_device;
 	}
 
+The standard 64-bit addressing device would do something like this::
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))
+
+dma_set_mask_and_coherent() never return fail when DMA_BIT_MASK(64). Typical
+error code like::
+
+	/* Wrong code */
+	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
+
+dma_set_mask_and_coherent() will never return failure when bigger then 32.
+So typical code like::
+
+	/* Recommended code */
+	if (support_64bit)
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	else
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+
 If the device only supports 32-bit addressing for descriptors in the
 coherent allocations, but supports full 64-bits for streaming mappings
 it would look like this::
-- 
2.34.1


