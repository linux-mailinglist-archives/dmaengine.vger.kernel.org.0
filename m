Return-Path: <dmaengine+bounces-7778-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6EACC8860
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7637F304A104
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C0366572;
	Wed, 17 Dec 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="b9DZKFgX"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8DC3644DC;
	Wed, 17 Dec 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984673; cv=fail; b=Q2OKCLhFCHIVm6Qs2AwKj7k2LAldgLdJcJwTU5Xx30CMSH6nVA0VjuS+q8D+Pm3sjtzdBurBUtCzLjUGB1yZzxg+BVlEbh07J/MYvwGZ8o4Q5mt6aa9Iii93HRqkU3mDIC8T8XUSVcSV7Su2w9HfpGE0Oop4EAWKQAdcxm9LSGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984673; c=relaxed/simple;
	bh=0A3xkqVWiRQ/04TfgJdKO+PKB+im5i+bWqzGfyELq3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxELWfccPCy1u93+geogV4OJUhvKlodo5nXCis8j4+HBAsKDm2IAVUGbDEsu5SwWcVH8M5fuM6Bz5QwbA+iazGfrqsEqWJtrx1dpct6mQxR5M9XhK2LqnGno7sTRXeO6vSCxQ8DVkfRCM821Cl6HfF0XeBknaK340yp4EdMg6jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=b9DZKFgX; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hdg+oPOyhrw2IAXUM7ojY/qnBoJLLLNtkO35xKNAJkzi/L0ddCiLZOqr+7oBtD2LSbCke0lomOW/02CArXY0rRCA0/bJlE7BlHw1NVwpaNogEqeQRDzjq6Yek5940C3i0HjKhno4YJnYhRdJjEqw5k6yG12w9EkOQ64HdEVqpmC+OFIfaTTzNbvIr5XRXSgO5MuGR8W0Yw/xrhweWcgZOLbztnaaAOhjh2OQC3wKi+4OfSz5wy7Zbjycke2YM5H3m4w5Ifh+7yLY371/hh94Xi9gDxyArzISgWbaMskDen65EMB8JtW55v5sQ05Mx+RN6dNYSvgk4Wg/ahVZ1J36fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UDTuV4vVEOzVHwmwk1GDcwOpMfmBdbAREqdadxzsRs=;
 b=T7eYgY9S3VeJKReeo9H34b8viSgT9P/rTZEgG1fhv/S9yYEBUB9TasPIASA0jn0Hex1SORlVSygsyB92egSKTxnW2gvl5uaoFDAbUWM5ziHQ2ibS3unLhqQvBbMDXqwYtZKX8H6sHjPWQ6uOSMcq3Af7siDgoKuZJpskTD+dECySMdS7p6MorE+CtytcbHHcGldtUP9tTBr/VP9IoLItZk96v67EA+GW5hJOozXU5wAVu6f22TKGuOJW90SXGS5TwCrw6SNeUjfVZOGrWKCK1gc2AviD6SK46ZBq5UmwnH16wtEpDniYnQgEY5lYmvB82GY6SMJGW0+W2HibFXT6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UDTuV4vVEOzVHwmwk1GDcwOpMfmBdbAREqdadxzsRs=;
 b=b9DZKFgXW+gpBrptliDHeCq450vMTozBpG6CsPZTTT9kB/mdxKWjYheBynCKHCtryioMt33Lp+0n/vbyCrkOJH4N4r2nvFgwD/dVBvd1gUGhDBI5akf083Lpi2QRBRQhCssMizopd8eq4Nc0EQbEedM+vNrcLIJY9CVeZehBaUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:17:11 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:17:10 +0000
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
Subject: [RFC PATCH v3 30/35] iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
Date: Thu, 18 Dec 2025 00:16:04 +0900
Message-ID: <20251217151609.3162665-31-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0103.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd0522c-29d1-47d1-e69d-08de3d7f47d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQOje/ItnzaUThsMbim9/kOeV3pFBMrmUDUo5uJAthWR9KAhr4ECaNk/bP1F?=
 =?us-ascii?Q?b3bBJDGbc+hiVAZJajAK24gYWxZE+kkiClziNmk3ocbNwUJRxdApG7BeV6dS?=
 =?us-ascii?Q?iQbDZgwuZWK5+z5gRorAlgH01QRIa7sQ+Uk1VXPvoiFSI4zpSJ+m4BWJ2sHx?=
 =?us-ascii?Q?o9ZS8P5ZBLvGUEltkDjC6E0Mj8a3NbLU0wjfNdFRL4aol/dPIPgXDZHc0F9G?=
 =?us-ascii?Q?ew2bPLWvySmlWNwgAw5CogcTLlCQ/nm+lip0j7hSwTwoYlgq5TVRW1HLlz1o?=
 =?us-ascii?Q?gC/7tc7C2R/bCkCRMirS9BS5mUP+PGMsg98NWzThGLkdFsCXjRScUsKbigkE?=
 =?us-ascii?Q?N+RIyp1RjA4qKB37HIQnP0A6bhY14hr0gq269mDs1RinyzXb9u9m5da9bPSC?=
 =?us-ascii?Q?HAy6u4FxRdLIEWFs6rhpZ/qVr+RLkbWafIpygMCG0kS8FVbfGdZhifCFWy9+?=
 =?us-ascii?Q?DK/NmxDvtT6WpXyC9aYjU+xWcN1X2FMIXtKi8sB+HzYy0YSgiANWcXWslEDQ?=
 =?us-ascii?Q?VPxh+dE1gxi4wEYSOGC7AA0xwh7NrpDQTzUy09BMglOEVblSUf3iEzAVQEeL?=
 =?us-ascii?Q?hfcFks5faN84F48kulQIGAjG6uU/Zl6sjOlzpSPDl3DnFxSjjJrvz7VpVwTB?=
 =?us-ascii?Q?d3K9FykwAHoUjZqS3VkzUC4/0WHLwM4GEp4Hq/oBaesdbbAG7ZSUBjzDlbqC?=
 =?us-ascii?Q?D5h4dA9y7mLOP/hOG5+zKZyNhs0P74ElADXhlVc85iSZb2fd96eGJYE1N2JK?=
 =?us-ascii?Q?VpFtjziIv1BEkok33VlPtAXGfWcM0mgDlqtf7LcdT1QgUeyMzwPIvNrLqBbV?=
 =?us-ascii?Q?55gcSmoQ8Pcj4XxsrQtcd4iG3g80KlcBJ7dKXriPpbLfzV/yL8NrT9+nySJa?=
 =?us-ascii?Q?ZA1NWQ6DQTKoShXC1sMAyqjqdsgSzwCwkhMgxphVr2zTyIZ9XpYcdRcTYbx5?=
 =?us-ascii?Q?ZjM2dHMmuWb1OlL8pLfYaPENT3sVS5rCfLNp6TyRBzBkAnme7S2M9GxCLlTY?=
 =?us-ascii?Q?dtM9UglztVcX8L7v1BDlf+DXYTbVunVGX+1YjJUqp1ev/jQX6hebuvh1UVT2?=
 =?us-ascii?Q?6unhVu6csyw2SHMc7ge0I801ZavZ9CFw7PyPBASHfFaOzLLgzJILcMQX4JY6?=
 =?us-ascii?Q?8cuYsQ+3wTOOmHBRA94Q7/8wgPCVMGkr9xxbTPqSQNLCL/QWLUhqA/64hVj0?=
 =?us-ascii?Q?aEewfiJ1kCujXuQ4TBKYbUgFw0XK9VeeXTgaxfkuOtTODwcRSWZYXSD7xEMA?=
 =?us-ascii?Q?8GV6YkUJ10S53umzt1PaE8a/A6ySl1yAxQW31ATm1l3vWI5dlyedEC7lgKJ4?=
 =?us-ascii?Q?d6kU/nCLPStZy4V0kxiFnb0sopNWcY+kqnluJrHJAQlAjf2jx/Rn6Lcxx/8z?=
 =?us-ascii?Q?pFRvR3P7JRQAIYmXtMlaX3IB34iutvIPqGEzRmp69KvsjW6MRrhaQ/EWYPZ4?=
 =?us-ascii?Q?/0GeeBijhrE+STRTkQ/9pByABY1K758s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tpzimicbd58QbSu3nPHcXQR1B0Z9Q+hzXXMncHGPEWHDb0Wv6bC38xgV+M4p?=
 =?us-ascii?Q?PeKdWz3X+DRtTaUKYQZvK2QZMeqodqwuGupldFdS1izF9Ll//Ddo4XpXLjs2?=
 =?us-ascii?Q?bgBW8h6n4Y/EzquHoe4oAEEd7JzQ7WgktHDR75DjAlKzdX5XZlDdgACmqsNv?=
 =?us-ascii?Q?jSZoyrx2YvVdzPxBqybpGeylSbpcBoL3tx5zDUAmk4N0D8+vobwlN/Xo8YMQ?=
 =?us-ascii?Q?E2ktzlpSLxe+fMVRJg99thf7G8xZKDHlJ+R7BylAFPc27f8sRD9ZP2E7O4aj?=
 =?us-ascii?Q?CVNory5Y9WNK882sxZYHJEvk9CjpRLrv90p1OqDLy8aUtlFoX8jfvnGgk2R2?=
 =?us-ascii?Q?0S/epp+AV0v3mWU1rhi4ub8x5nRxKbZRMbgYCEC4zc2ZVx/5IKZ2/aDNEo8R?=
 =?us-ascii?Q?NiXUUK4jmMRgFw5TAybujiawSKAkooS7XLQ8a72K0q1DJ3EDdm+DuM5yaimZ?=
 =?us-ascii?Q?ZoqttGPsP2R8gHpdL1u0TszmYIanPXYTU21FSnxd16/hh6SOZj3E8r8uPoU/?=
 =?us-ascii?Q?GCqUQjWZsyJx29/0Wud3hQckPIObl1a7T2NUOaiQYdq4xBr078pu5wYJfHji?=
 =?us-ascii?Q?XTQzKvBqCCgcOAqjJ7CkmQx1cSmf554KwLKTR7XOUlDrJxqITCcbgR0pcw+h?=
 =?us-ascii?Q?/iirza0w5QUai63dinlBDj1Xii9+lvw1NW1C0ad5T7IKTk+MvzlFO9N0RzRg?=
 =?us-ascii?Q?Mr1frxEEdFOVowjvzDp6g1QmhMCQDnV+6eCkzycJMjfOQr50aEkMN6rNg/a2?=
 =?us-ascii?Q?dDVjDHmcILJfpmWeuv6SWimBRRo+1BEP02jXZ6UHypT9Oy6Vi1YBjDuKSdpz?=
 =?us-ascii?Q?BEZw/HV47sTHM6kQMGkZkT+z0l65H+4u112O9oV+Whhs/Jpcig7ZP99XX7Xx?=
 =?us-ascii?Q?EgxJT02ms0kZ63M+8rlSPesFyPVtm+PQhDTKALvsq7tRqwC9HcEQgy8ypvQV?=
 =?us-ascii?Q?55RZxMTftHfFaxI4ujo+SZ8vlhFtaBGMCeKboqIUjiU8yTUTYuUP+wM6CpNk?=
 =?us-ascii?Q?Ya6t2zBfHtI9calZJuFDNJoH9q9dqCqY/8IzY2H5uOw72PNT44N9Tz5LKA/f?=
 =?us-ascii?Q?vKA55kZbrnFWt0ot1kr1LsUnf9S5gVgIvT+8cQeyeG9rmBqQx2kXd6O7C41n?=
 =?us-ascii?Q?wVJ3rJo3Y07MKH6znFLFXNFq+DqjJAztrSmneXjvGuUkHqgoKLRxCcMmb8Hq?=
 =?us-ascii?Q?HM+o4iOjjGQOq0SOQ9uAq4NYYvyKRWoNjfv/1jsM2pxJafQixRhcx8MdFRhn?=
 =?us-ascii?Q?4IfD2f26fr3Zpno/dS/SD2rkHr0IB7n1TEhqX2AUqMxS0YFhITJHhpaLSXBt?=
 =?us-ascii?Q?gYcLifDOhIXKLhkCYYnTW/rom5x0fOfrtOt/v7MF71ZNvs/EPGYIMwZnmsxc?=
 =?us-ascii?Q?OWsKSiaJKRXhc9emqJJKRmyc9FiIkGBs3xQqAGMXD9lOkd51/WSqK192aTwB?=
 =?us-ascii?Q?x55dDIuoCMFwvt8g2VT53ufmbIwB2Vt33ba3IfYEWte96ZNPW/Ecj6MlSLpg?=
 =?us-ascii?Q?kTg/NsIrUCmPVjmfh33qWPi70VXucIyDm4HkKohc76Q4sMG/UmwWfYpw/PFM?=
 =?us-ascii?Q?19vfSm7/P9LxvJ5QkmfuS0TYQrnGwzxeRnPA27Jhoq77w/v2+Axwu0oZDIHq?=
 =?us-ascii?Q?vVdbrHUGe9UCMuFNFTIQk04=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd0522c-29d1-47d1-e69d-08de3d7f47d0
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:40.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGe3+Imlhe/Mica2YDizBkDcxMKZeBVSR7ozUlgZgdTDupYgK7MRb+bBC8G63DNmNnINi2eSfpzaaAryfXNK6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Add the PCIe ch0 to the ipmmu-vmsa devices_allowlist so that traffic
routed through this PCIe instance can be translated by the IOMMU.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ca848288dbf2..724d67ad5ef2 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -743,7 +743,9 @@ static const char * const devices_allowlist[] = {
 	"ee100000.mmc",
 	"ee120000.mmc",
 	"ee140000.mmc",
-	"ee160000.mmc"
+	"ee160000.mmc",
+	"e65d0000.pcie",
+	"e65d0000.pcie-ep",
 };
 
 static bool ipmmu_device_is_allowed(struct device *dev)
-- 
2.51.0


