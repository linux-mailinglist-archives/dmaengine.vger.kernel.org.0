Return-Path: <dmaengine+bounces-7782-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EA8CC8FA0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 18:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D7030505B6
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF936BCD1;
	Wed, 17 Dec 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hOXZdmzD"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76923369961;
	Wed, 17 Dec 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984679; cv=fail; b=cnmdaEFPvXyXeFjv0dr64uezJbTIfdMC3LPbnRWzUXOn6jMphRTVGi/bpIkzuySuCRzXaGteo8hGdJLehQu7IRzWFlLhKGmTly4XuTP7g6ByJnZbqEJxCX2dneNWquxi5LKPUJFPxTW0tLrgYbv0RBPjaPEAdcKq7a4S8OQCgOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984679; c=relaxed/simple;
	bh=KHczLRKzEU9I7MUN93nztdFnC/jY1SAO4ejFo/LWSQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ulp/ypoMeHcWn40+1m+wfhXOVr8NS1JSLd3QVJkPssXt/fb7TmUGdDJv6vOJCDxhrMWt6ZJUDZr7j/Fy8yd5lVGxbi1uCnJ5lpvNXxVpJLcDV7/NEYroIrrb2wH3us3rendGZy2bMVAAHsdoD5sWgNGQq2OWAbSFXMbCNMTsDhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hOXZdmzD; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4mAVSqkHO6p4Q5/l6YuR4Pl+rBUz19s1bDtPl5bXTf4zqisNIzoh4oK4w0uShHQHgtYCBSIXGw3l5yJF+7kUxTfBs6Cr7OOntFmUb53fTbEfi54BQ8WvvzZEOPOHZbos2gDb/Jx48PHb0Hv4l42S+V8wpcXEL5iRFXlytZaEcE2MbHQpXO0J3k6WJtSxvQc/fdGgp+xCUpDxt8W0vKKF9GzMvYtoEqk75zSfYz3SX3qn+VtNC3eeyQaVy8CPJncTTrBhs+PDP3tnWqyTvdZYRj0f8uqooIbtm656d8+HlFb66szooUOOBuXOdvoIgvTmtNF0u2PrsUvSuaqgP26tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMf1cAyKI/b2jaj6QuU0SVT1Up8xyU1sjq6QlDS2O+I=;
 b=JTnh0E3PAN/8FkGm9/47pGI35l8l+GLNFcyvxZQfGWacfprWSGW8WY9iG2Npp1wERkK6Nl+ks2zrUs4JQJiEDSSpv/iLN3QAKGu+h7ocGhUXRqIjZ+bpvQhWkfyxkICL9X9wAIB2Wfr2wWw+Vu1mcq9SeuFyiLG1fEOiHjgtlmVLO4bRkTheOocO14gihMe/9ybOIiS2WBW/cX0dBtkIcHJen0oRO8ba1FWXyQzYUMtciuNl82J+y6SxpGDkcK7HxctAqETAfGFRbE4SkqnNJD2kUVFgEUmvXJw6ws6Sqn+L8aTgo6A1/tCMpjE97v/8nqa3pKKZQS+8+QMMNqk2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMf1cAyKI/b2jaj6QuU0SVT1Up8xyU1sjq6QlDS2O+I=;
 b=hOXZdmzDEEABt0mXbuvxcSX2JjCE/xzgwZjhvvXbirpmeVIFXAFscc+LUfooxJ+4V69f+qGjqzgAhfU3IGQfVx+nmTmTCRUhVZjM2rT7JaUkg0C89lcki1yWSkjKD3UCRNgQ+OZhIokP43+nyLiHW9AZGFWl/CD+bA6tpncu4UU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:17:12 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:17:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 34/35] Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset usage
Date: Thu, 18 Dec 2025 00:16:08 +0900
Message-ID: <20251217151609.3162665-35-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::17) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: c36a75aa-56c4-4471-f1cb-08de3d7f49ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dVelX3u2lSeJSj1aXcAarKN1ChGvPs6StLyxzFqTfM/tt17rchVCyiGoQgCw?=
 =?us-ascii?Q?yics2JGkxIJFmM0CkRCNgzJmV2aT4iD6y5xWhlku4bHU12Im4tiqWI5yXKN2?=
 =?us-ascii?Q?MpLNCRbDlGebk+cRX7spWYL68CKwzDezIVV/4/WItVQLIR82wMHZz94SBpUW?=
 =?us-ascii?Q?NW1NhbaaE+fS7tsxIIPNMeqzbq97auysHph1Gpd00Y8TfT/pjelcmqVIPR4q?=
 =?us-ascii?Q?lju8aiFlKe2pCVdeSJrkA8Y4ZfI8b4zN/CgQhIM14XXtTm8ZdClm6SOnj8Px?=
 =?us-ascii?Q?ufUQsOQ1N4LZBOWkPVaZIEAlAwPxIgRHeyXy2mHAsyictpgpjF/nh2ofqOux?=
 =?us-ascii?Q?yFzzn+SGjlQh5iZYf2AVNZBoo74hSydzqr8LCWtyq21h81n3l1q3Hs4LGMjC?=
 =?us-ascii?Q?2EP+Hrlum8Vv97md5LUh7wtHaG9qZ/22jJRY6jUs81osPrMmGjtYW5zxtxvC?=
 =?us-ascii?Q?IYezIixtVxU7sFeLh3IdLz7UVtpohPNIjhMS3+02WF/xl9HH0KE6dIuYmOHF?=
 =?us-ascii?Q?GLDmYclXNkE/xMYCzVdOAfD8ZmmULpkYsuFkIAY2h4X8h9OHIp06S+cUPIuU?=
 =?us-ascii?Q?bym9vGf5WqE9T8USVUnuSrgdNxSc6QygKxhXgy+4jWhkdVRDz8BudXI3jwfZ?=
 =?us-ascii?Q?NLka8oDp2hg9I9CN+z9o5Ey+Ay3NAEGOpIRV1smP/uYrddPkdmcIe1Nc0fxd?=
 =?us-ascii?Q?7izNZb4jpOHVwWz9xhNb0jqBMv3gfE++cBiuMcKHLiEMyiiDFtQUeG9eYJow?=
 =?us-ascii?Q?0vDKK9zB2RwP1sELA+5LH0pIVqRUubewV5ohvpy+Up397dzJe5xFVAEgEU4+?=
 =?us-ascii?Q?FnTeumGz4MzSTAY5NM5SJifVmWMtCmO5CaXZ1ZXaBj0FuNQ7kSSKx2+RdagP?=
 =?us-ascii?Q?Iax4ZhOpaBp8ovda/MtQB6bsUbBxwbr3nCqWDW+nXic1IE05J9TGbyTRqQ/B?=
 =?us-ascii?Q?/ip6LnIJ7z7JRi7JzAxQx+RnB2g73Zt939m2ZVokc+3UquEap7V6ow7uaj4q?=
 =?us-ascii?Q?V34pBEZQJC/MGZc/AJQY2k6/m1+8LUJgIiRrumfqk9Ug06I5ll6nqxFhZVyt?=
 =?us-ascii?Q?c+I+axorXtRNiDgRx0g8aXEm0pYjF/Rwf0wTJrF6Is4iSFUBagndZVVOVc1B?=
 =?us-ascii?Q?uc0+F5gBJ7vjim7d4IdokWdjXGgWzPotmX5nzecL5JfWT4w4+at+BdWWrCH1?=
 =?us-ascii?Q?5QrWH+dLdVZxjUBXGPPtNA7a8e3VfmJdP4bUFk/1RA4x2Bo6Aryy91/+vfDt?=
 =?us-ascii?Q?/PZ2NEjxOcHzhBVW1pG2Vay38MURWPIhsm//3d0wzoNzC080mTirshGt6St9?=
 =?us-ascii?Q?nx5IV+QZ2hGIJzuIfbNuyLIOzroJpTtSBzxqYJNLEgVr7/IphxjY9Q2W3bWl?=
 =?us-ascii?Q?ZyMCOsHduHRyUmWtZIy8N6R9gqdMCj1hI5L7QhPAkgMsHNcaizxF8tDKsH/B?=
 =?us-ascii?Q?cTvcNW3UKw/RX184daI+9eTdZUoqvd/0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d+fLMdc8hg9l3WBx6hq0V2Dp+mxkM3Yev0oHAPLj0G1CDpvwpwJhzGVuZGh2?=
 =?us-ascii?Q?c2a8w/QrHkAzlOlttr8ebMYDZRrsXGVQcaEXMCLnHBu+LeL+guQzT3hAkw0+?=
 =?us-ascii?Q?CuHgTfYfPSbxmc2Qv0LBOiKINtTLcUv1i8mfEogiIqnUI9lyRg2+LBxVfxtu?=
 =?us-ascii?Q?tYNhU92vpiqDP1nOO4yWuRiSAp0Em2eWPOWcj8BikY65avloy5AI4/eJOEzh?=
 =?us-ascii?Q?j6lK94ef2LtFnzJ5UhJaw8K4t5rKL65vBL4rvP9Bo6JWZpBRW6bW5qWQIJ9Q?=
 =?us-ascii?Q?Lca96ArAKoYKcTb4X2l88FRbn+b3U4IOjwycbDOLu/XCRBeLSuh3cuEMSBFi?=
 =?us-ascii?Q?5wHpDg7S0Uuk2Ht5WrDqqgBXDRECOazNqKBGITzOEvs05fF7XISFV1aPvCMy?=
 =?us-ascii?Q?wtfm5BiAbBRQ0wxCqWNew4qcfF0FTzg5GGdUemStdRbZqnMLbD0oI9WfKywN?=
 =?us-ascii?Q?nVALOKvGj6WGRJR9yXGOOteLCEFGDZ35zD/M/wq3T2MhklDv32ve51lIa61k?=
 =?us-ascii?Q?ELSqoSW2n5Q1q2O4VCMqWxqVY6qI+tUZLnwcJGX8Iy3D6f6DutwmVzrxGCYW?=
 =?us-ascii?Q?NaW8lb9vaJPTmdwCBiuY1I40uVVs7P7n+H/THNkkOmzG/z6IKTPEamndM6qT?=
 =?us-ascii?Q?GCXomhv40KnhScv5l0ZZoG5TkdaqHgw0A/zdxR9iEHWnZ5utNMff4cJ4wC5Q?=
 =?us-ascii?Q?i8zxsXujVblMBahmIhOy+2ALBV8OREWZHHCfT557TVh7OPucS2gviO+kI8pG?=
 =?us-ascii?Q?cf9FCbF9VLeq2CVx/I/W/yV+T4CBcPwwM0iNO+fHqKOzBJFCka3pLjrGudhA?=
 =?us-ascii?Q?umc3ZfDHqvgoUYFSD2I8iLliiht4nB3X6TUna8OhnzJtMxnD+/NObmMATLeQ?=
 =?us-ascii?Q?MpSK+qPvf9m5/B0vg9fO6E3tNBOsxoTjbjHHnbuhBck23VysgqWe4BvZ7xIF?=
 =?us-ascii?Q?FSw91AGZl7gD7jCFq+HjFQbcySwAWgJNwOdj1BQZFegHqhwlbOK4eOY84NBQ?=
 =?us-ascii?Q?uLRPueeIuu5sI2Rhdke0U0S2Vt+Itro6c8y2mLaQ3n7cukPNEvkJIb7rBvok?=
 =?us-ascii?Q?ETZ7zxJk7Sj2shyzWBu7dVJCenDxTlhg1NGLKnEpoXavt5mZFa77xGOrP+PM?=
 =?us-ascii?Q?FYdbOmX4/eA8tVzwUId8qfIabAcKYAY2y5b/XTDUpBogA57Pf+zgBotT6DxI?=
 =?us-ascii?Q?4ddzCJVfugPuAFd2pZC7IU68YCSGjb559nUprEeTR/uyprUzx1DK5wsON46z?=
 =?us-ascii?Q?3qxryWKQhxpiAPHm41ZBgvDtdGrkhN+unWR84cvAsZkqzm0HN/ZUuNCFl6Wb?=
 =?us-ascii?Q?CSg9ZMwzX1AEgdXY2C0ZbGuBd0vqdNK9EzO2Qk/d74aQ0mX6D3Bd+LzTFO/s?=
 =?us-ascii?Q?B7AV1YFR8d4VxJzZMUYDzfZ1FRbR3o/1C6t0YF46fH2I+oDyzNL8dlYXkwYF?=
 =?us-ascii?Q?SOla1rODhigbljo1rg/dQip/EGUqZrSvLAVbkGe6uwHaHJMjpo9wgw4Bjs9y?=
 =?us-ascii?Q?ZGsUljF8csnTWQz8i6zwwz7afuuZYwzuyuqs70lTjo5hwCD1E6b1LdXlG4EV?=
 =?us-ascii?Q?HFSkCI6tn2K4IBMUk8uN11oDeMu9SnVLiU1164TsvVE13Y1RuOLOjPGkX6Mz?=
 =?us-ascii?Q?5195GhfEXqgfMCZNe0k5vRc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c36a75aa-56c4-4471-f1cb-08de3d7f49ad
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:44.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T03rdMcUHyyvS+SIkFMgBHZV7CHPBw4baT7GVXh1ETk+RZQLSgN7a51TQG6aewJRFXFfDcWIeYmAmwfazbNZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Add a concrete example showing how to place multiple memory windows in
the same BAR (one for data, one for interrupts) by using 'mwN_offset'
and 'mwN_bar'.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 9a7a2f0a6849..bfc3e51ab79f 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -90,9 +90,9 @@ of the function device and is populated with the following NTB specific
 attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
-	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
-	vntb_vid  vntb_pid
+	ctrl_bar  mw1         mw2         mw3         mw4         num_mws      vntb_pid
+	db_bar    mw1_bar     mw2_bar     mw3_bar     mw4_bar     spad_count   vntb_vid
+	db_count  mw1_offset  mw2_offset  mw3_offset  mw4_offset  vbus_number
 
 A sample configuration for NTB function is given below::
 
@@ -111,6 +111,16 @@ A sample configuration for virtual NTB driver for virtual PCI bus::
 	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
 	# echo 0x10 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
 
+When BAR resources are tight but you still need to create many memory
+windows, you can pack multiple windows into a single BAR via 'mwN_offset'
+and 'mwN_bar' as shown below::
+
+	# echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
+	# echo 0x20000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
+	# echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
+	# echo 2 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
+	# echo 2 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
+
 Binding pci-epf-ntb Device to EP Controller
 --------------------------------------------
 
-- 
2.51.0


