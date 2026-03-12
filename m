Return-Path: <dmaengine+bounces-9410-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB74BqrwsmlBRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9410-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:58:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF852762CB
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2252F3257FF0
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B83FEB2B;
	Thu, 12 Mar 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pEwqcalw"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020091.outbound.protection.outlook.com [52.101.229.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701C38238F;
	Thu, 12 Mar 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334256; cv=fail; b=OmpfUnBNRrdRcyR/3ZW+37STOvC+qqNowFf4wylEY/JxJAjDc03x18JKxi+trBMm+rbBL7oiTp5LrJ61jXjWhkQNchkrznmcGTU0UfqNZJqPfsvRsLvV6VapaS5kACzA2vOQsvcsyjGgssClQ4PhDNbQlx2GmgF3R8ztz3mTSnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334256; c=relaxed/simple;
	bh=p3uFj3NRys9Lx+coW9jo8Q5Oq93h2WEweng13oM3LjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A75w8kY/PdqghLwEwWxmwEEkLAtL5KLfJjc0Z6el0NdZAvL69JyxkK9V3Lzjm+evHnlVkh1Sj5P/wFtuvqXTYo3hwexSOpxiIYt7zQ+sHsXswK7gDZvXvzOXN0KBaVBiqkNe+Yq+u5k4g72hjcvLKZLofTl/6bBRKB2og9fgzdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pEwqcalw; arc=fail smtp.client-ip=52.101.229.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRJAmTGVxzfpKF0DdIeto6m2YozgH0A5ru4AA8lszL19Bgmkna9mhMdghLEeYh43gch3GDxvnz2lca/SVY7tvENandWkHbs36qz/UrcmODqJVk/asZNsYy7/CRW4xynKO3y2N1/BMVmTP9ir0lP7Qym9TVZMKit0NZJbUy8zZKr8dtKVp/MlJvlZMzfMDOKgErSM6wgksspvA0Hsw2T5V0QJYJ6Rz/iU21uwBuXFikol4xPjDFANiMfDTt6u4lyV5Cy9xAfgimGS9eJ4cyyYcEWHvRaJy445NUjYSFmTFQomVGGjR6PzaJe4zRN42aqbMDOWS6Z7XvIy6TzICsGZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4tg09Q56VUnW52W7jytsJgiJudl6J/ZcAfXa9juMq0=;
 b=WTEM+Zg/Aw1W6L9cCOtGv8/p5JQasi54N9VhDTZNL5R2rfDpT+C2wV2MHO8nGcwXXqAUQcLlzsOOxHwCffjclIwYPpmYhNTYsooEybJLKlXa/H+Ru8LW22mVEYNF4cNaNNnMGIjbfJJFyB0a6iNQfe7j7aKVt2pXOlkNNr6w7drmilEs+Z6Ou4q2kG4ELSddGYn4iiJ8NU81yQO3CZ2rNZfzKFCttjv+u7hICnLKCpC4QVD2hR1mg77Ngzt8filHrmoTe9DcqG9aX+3/46IXI0G9RrRi8GLdD10c7l2REwpSoMFsP78kvU+w7GjHBaDjDwSReS2hQYNgrdTEaH9X5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4tg09Q56VUnW52W7jytsJgiJudl6J/ZcAfXa9juMq0=;
 b=pEwqcalw1cAFdxwDVJcaM61Cpf5+k0QZM5ykLID+Xw4oa48oxZMTvboI1cwzTEwbHnoLjwjpsSpmVxnsFzDRtpdsXKxEajFxRWsAMDoS4vuepB0UEwJlyL6IaLLa3ncNTZmlxlCRC4vUDFfpuPPN0r/eUI3kXrtgihEFnyhWap0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 15/15] Documentation: PCI: endpoint: Add vNTB DMA export HOWTO
Date: Fri, 13 Mar 2026 01:50:05 +0900
Message-ID: <20260312165005.1148676-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c09369-2c57-41b7-93f1-08de80577411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vtA1siMsshEPBWVmWa4b7C5lG++E05TnyVxQ+lZKk9e2VnqDCtEJHhhPBnUgL4hQdndohqtJwuAdpGT21DVMGkzIU7MAteJBj8xaZY2x1Sbf6EdO2nOXbi0eypn8CyzSsbd8YutGErUystBi2E6mNPnShPgtB7pD5fr3t79H/iFkcGHtqdjdcbZynqXDfzWHdcEcvlyAnSWNBnWytHfCpMaJZS4nt9fO50WpEfK53ljaMW1EL1/ZD240eACyhoRep7PiDBPVNbIdjpEAeNvhoP79LqhZkgVboIkKL5huJ8Z3a01ngupVzDeKwWML11F+qbL8ohk/dmx/5lWgrdcRddPenAUc3AjdtP0mdl5nkHCuC/MiFpGB1ZmKZWIVDe7aQ6cqtwcRNGFdg9kKI5OXv3BVQTR10vlJIXw+yXgRnk+eWB40YlL4ayscDyGX+1S7IuT+NlJNY1JhSMGLIx4twP6x3PJq++EeBl1t4S7yYEdDr8LIu+foshFDiktrRvQBUahtU9ShJ/jXD3Oa6OukcqVPcsuEBlB9QxilFmNHmto5M9eon6wTVV5PJfyokYHwhxmIEPkDfZO2Gk0FLyUEa9Tl9MicwXm1PcWFdO36ebOr4JUMhlo0FoJ9GiskVthEYQIDvnhjtOdDX61+oKQN+rTbRNY2iwE44+/BNESnjhX3FPqzw9pXBqUyJEtugGkXLDLBbEJP5cNNh17OGMn8bHsrLfR/JARuL9BfAM2dtVX3BG83ZgDNANsXv+o2PAbzpdCqw/SfbdsXuk4R9V5BPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQIQ10vDKgUpWUI5E5lWJ0VTNm9Zwa65KhDFmNsYEkxf6jT35sls6hctOrWO?=
 =?us-ascii?Q?i5SZlH1zT/k3llJzxqdRxccXsgb5jm2+cUbkg8l2JKuF+j8o2HQu1pJhgmHd?=
 =?us-ascii?Q?OxDUwx5+LUH/4oY5F/zgSnoo6LD7soI2IklCM9k3DxENnUW9Kl+L5hUmTkuM?=
 =?us-ascii?Q?sKUo8LTlv/zsraGhvSIca86MJCuCNmLhhL9IehGDy+OS5VeDPYJR4Y6pCVNx?=
 =?us-ascii?Q?5OC2SgKNrIyuJz7QOZ3VU/XyNrV3C3TclQw8b7MFIgdnxoCctw1dgGFccDZw?=
 =?us-ascii?Q?kR0jbKS8oxMNJxMNRdz2+MKTtXflyZREyMHUqTlD4vmG11yJe9d/KqXgr4F2?=
 =?us-ascii?Q?rihYJhlrmqEEwef1mHrmGD5a+uvH+8fksmGQAi1J3RxjxzXAloLY/WiPP5St?=
 =?us-ascii?Q?R9105Istp/F2OYEvxJy6i+3kiAvIVBS8hc+WET7n19lvrF5HwWd4KNoXJlT1?=
 =?us-ascii?Q?ifyH5VFhxtdYD8AI66QS1p9WXhKGcZbYmUS/JFy3syb2/UvqnMH62tqJT5cl?=
 =?us-ascii?Q?CJHGaklBn7XUBRw2WheE0xSUI4iOrPXBpcNUXpUq/zkmVVLQ7od1XMZZ0D4i?=
 =?us-ascii?Q?7/HZRu71cPpMerCyvkwR2tBLYpjCs8fIxy2TcKs51XJq3MvU+cCZlCCi/0Yb?=
 =?us-ascii?Q?LJCfQBVtuB6AJPdi6MKWjW1qUdIofb7sHFyLuITTKdsNg/45Nkl29jyJrUrb?=
 =?us-ascii?Q?6JMaBG84SRBOm9lYxBF8HjvQ003FjYtNdDk+U0u8zLVk/xmDp3CSnQH693sa?=
 =?us-ascii?Q?wgJ5S1XWBpViui+vkPBzEZcCAEhQzlDM/H6E49Hrf3DtQY1eUUieX3atBYmS?=
 =?us-ascii?Q?reCck38oWv65TSE6AipGyPfJFGrW4dmfat1EyEnCqr64R/KorEFnR9acDAz2?=
 =?us-ascii?Q?CUpFN7cqpzufIjuWpXWF4tcXLuUUD/Oen4PHqv5tVvdzO8rC4PNR0xlYjGxc?=
 =?us-ascii?Q?vb4cqsKWoDPpXCmRWOdVplRT5NJOALTXWfGB4nwI/L6ZyULNVKij4d4xce+t?=
 =?us-ascii?Q?ISfbk5e2YGhuOCSuKsF9GkXFy840/LfDCoh7HaKRoB+DAvhamLKxyl06765N?=
 =?us-ascii?Q?+2bdtuzrss6B6iBA0IRcXipy1oLAUP9q+fpScqea/bGDTc5/53Zo4cli0PQ/?=
 =?us-ascii?Q?mXkfl1kB/Mvc46RAvG72GkofOzjhexAGktZKj9XShDraghVVoiL6iMLtGeWn?=
 =?us-ascii?Q?BCuQdO7Iq6N4GA9Nd04mdDXbnQDnjzYUndBVUQXYSCjHbfXHU4ZsuS67V9AN?=
 =?us-ascii?Q?wS9VGiq0wo3bRjWCVvMr9dnXOQtD1SUCQKHuQSymBhK37G1SVXcB8s9ZtD16?=
 =?us-ascii?Q?rPDkEhy8/j4zevYcShI0zq76M1ORh8Auew8IDBwLb1dRKr7T8ADS4Lq11MHv?=
 =?us-ascii?Q?0wHeNW8GA+7fy87fw35+vlr8S5qq+2j7eujeps7xixZilHLzShaR41Y2PQ5S?=
 =?us-ascii?Q?Y6xgNEpCBDzB8IUIirEJa0LQNu3Wgi1A0imi7IPeljbEcC4yIi97Xktpq9xa?=
 =?us-ascii?Q?R08hWVu56uzW3L3mOK3xcSu7KPpvCWv3OQcyMXCZDsEH3JMLeIdAS4taWuSY?=
 =?us-ascii?Q?w2WcGjACVIXdDQEkKGX53JgFc0tGA1KTxPYp2VnPG5pY7OEFtc1AZkPN0odq?=
 =?us-ascii?Q?j8Xt2RZovg6sh9wdK8lbb3lLxsu2U51plCpmSYBmNys/uTpf7/7kHCiaf7D1?=
 =?us-ascii?Q?PoicC2iBpGiMozsjSDoFMC2eMrJiuFtbUY2HpTkUYXw4RA+7YiaH2C/x0BjQ?=
 =?us-ascii?Q?vIVFNh3uIaSHgpZ6Eain2zxeTq5H/8gcDrfki0miqR/DQvYF0fJI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c09369-2c57-41b7-93f1-08de80577411
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:23.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c1nHg+aKziI9sEdcXaDc9MqOnQwBN61BXRAjetLMcj4OetFuuVH+gSwppqPOmcELNEKeEHRrUjT1yXEFwok0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9410-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 9BF852762CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the new pci-epf-vntb DMA export model.

Describe the configfs placement knobs for the DMA slice, the versioned
control layout, the two-stage BAR programming model used for shared
BARs, and the host-side discovery path through ntb_hw_epf and
dw-edma-aux.

Also show how to exercise the feature with the ntb_ep_dma test client.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/PCI/endpoint/index.rst          |  1 +
 .../PCI/endpoint/pci-vntb-dma-howto.rst       | 83 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-dma-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index dd1f62e731c9..c3f93f1da34b 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -15,6 +15,7 @@ PCI Endpoint Framework
    pci-ntb-howto
    pci-vntb-function
    pci-vntb-howto
+   pci-vntb-dma-howto
    pci-nvme-function
 
    function/binding/pci-test
diff --git a/Documentation/PCI/endpoint/pci-vntb-dma-howto.rst b/Documentation/PCI/endpoint/pci-vntb-dma-howto.rst
new file mode 100644
index 000000000000..c3acc4e6ab37
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-vntb-dma-howto.rst
@@ -0,0 +1,83 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+pci-epf-vntb DMA export HOWTO
+=============================
+
+``pci-epf-vntb`` can expose a virtual NTB device to the host while also
+exporting an endpoint-integrated DMA instance. The logical DMA export slice may
+occupy its own BAR or share a physical BAR with one or more memory windows.
+
+Configuration knobs
+===================
+
+The endpoint function instance exposes the following placement controls via
+configfs:
+
+- ``mwN_bar``
+- ``mwN_offset``
+- ``dma_bar``
+- ``dma_offset``
+- ``dma_num_chans``
+
+The offsets are BAR-relative. Regions packed into the same physical BAR must be
+non-overlapping and must cover the complete programmed BAR aperture.
+
+``dma_num_chans`` controls how many DMA read channels are delegated to the
+peer. If fewer channels are available at runtime, the endpoint falls back to
+the maximum available number and reports the effective delegation count in the
+kernel log.
+
+DMA ABI v1 is currently defined for READ channels only. The exported channels
+must form a dense prefix of the endpoint READ-channel space, and the
+``chans[]`` entries in the ABI header are ordered by remote hardware READ
+channel index starting at 0. ``dw-edma-aux`` relies on that ordering when it
+reconstructs the remote engine on the host side.
+
+Control-layout compatibility
+============================
+
+Offset ``0x0c`` in the control block is used as a control-layout version. The
+legacy layout is version 0. Version 1 extends the block with per-MW
+``offset/size`` tuples and the DMA locator.
+
+``pci-epf-vntb`` emits the legacy layout whenever the current configuration can
+still be represented by it. This allows a new endpoint kernel to interoperate
+with an older ``ntb_hw_epf`` host as long as the deployment uses the historical
+one-MW-per-BAR layout and does not enable DMA export.
+
+Deferred BAR activation
+=======================
+
+BAR subrange mapping cannot be programmed at bind time because the host has not
+assigned BAR addresses yet. Shared ``MW/DMA`` BARs therefore use a two-stage
+programming model:
+
+1. bind time: configure the BAR aperture with a temporary plain mapping
+2. first host command (``CONFIGURE_MW`` or ``LINK_UP``): re-issue
+   ``pci_epc_set_bar()`` with the final subrange layout
+
+This matches the requirements for EPC subrange mapping feature.
+
+DMA export and ``ntb_ep_dma``
+=============================
+
+When DMA export is enabled, ``pci-epf-vntb`` publishes a logical DMA locator in
+the control block. ``ntb_hw_epf`` parses that locator during probe, reserves an
+IRQ slice for the DMA provider, and registers the auxiliary child only after
+``LINK_UP`` succeeds. As a vendor-specific frontend example, ``dw-edma-aux``
+binds to that child and exposes a DMA engine provider for the remote endpoint
+DMA instance.
+
+The ``ntb_ep_dma`` test client exercises that path. Both peers load the
+module. Each side allocates a local test buffer and publishes the DMA address
+and size through scratchpads. The responder only waits and verifies, while the
+initiator triggers one transfer with::
+
+    # cat /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/ready
+    # echo 1 > /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/run
+    # cat /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/result
+
+The initiator side uses the remote exported DMA instance to transfer into the
+peer-published buffer. The responder verifies the contents locally and reports
+PASS/FAIL back through scratchpads and a doorbell.
-- 
2.51.0


