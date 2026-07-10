Return-Path: <dmaengine+bounces-12291-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hZPyHI2rUGq73AIAu9opvQ
	(envelope-from <dmaengine+bounces-12291-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:21:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C54E73861F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:21:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=E7oz+P4R;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12291-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12291-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 148983038CF3
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D53F411A;
	Fri, 10 Jul 2026 08:15:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D23F1AD5;
	Fri, 10 Jul 2026 08:15:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671343; cv=fail; b=IuSQDI4lFEk/cp7C2dwPGPcZbDS7Ifgw+tloifBsZ2tpsiqSPhFWM9ZEKPueqi/xaxSbJ8OpBQkvlnG9gbrc5KV5dzIqqJ8RdaaTUxWSN69PnQWEW3QEKAQYniYBRYPyXJ9OgEs1Y79FeNXeV3huJ8zknJ7USq4jdakDNh8JrcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671343; c=relaxed/simple;
	bh=NRXcuhPohlh7kJIND2/c8PPECWMdwJ9KA53+zkwuuR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqpoJDd1p7nGWv9l5O0eEN9LzHQO9+JPvLBgemJ1SakRCLfwq6ZzZANjrzU6lUOD5eUbN5t9JiexfecDi6Fr+cVAzltGjIp3cw732WTOQp3ZmlVItAt4gsIjlIru8VwKbH1gSgBjOnje2XPiw9d0rXJv8RLyCmzE0jTU6WdezwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=E7oz+P4R; arc=fail smtp.client-ip=52.101.229.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BV5f+HmbsAsM/dThIsn3ICbWRZVJhlfggZo8fOfT5QXyvUn6O6mCZdjwHFi0f9KXMS6kfLAmLrS2Vu2m6B9J/gwm/eeP/WnVQotQj+1cakCF43K/rjLjXzQd8zbnx26q8Dn/SI/ngJed77P2rocbj3IzWxMMBc+v2+XA3AQI2e8ggNDb+5XrktB5YEsaaqlhLo/y/CjLz5yG995FDZol/XbWnieGM+mlREL54zY1SKkBM9zzqiUNcz6IaJohrb4iU1NG99DIFA4JHNziQCK3AYPljlCeTym271geSUudgfQIZBVn1wnH/WKqujcY1OStWgfFe6mmel6rYWihpVC5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw4ZCMkMqb0AQLjXGOZ9t0j4tBQyEmdisgCi8ZIZET0=;
 b=ObWA+VVm0W8QS/EZIehaIx4p1TApH4kKsDsL+YC0C1CawpLuMyDCJ2T1iFagBjCnqHIK48rkvy8ct0yrdw5DsnyViJq4mo39iCwJPVPSbA/r/zf/j7jaNF0toJ/Z55KsRvkAwxIMHCq3qZ3l2ijxO0jn+0DUpoFI0rK0A2rRm98a/jXM+9MWOylgiKP+I9mSz72zvNBvqTvJHysX0F8je8aIeU1nNRhWgzg+SmNXebWg4rb310ad8gc2zSiFKE1QyfBR06JSEN3Om4aYCTTAiqzMK9OhsgZ1bNUF34Ip7kFSM357/PWE06z1RChi0kmFjk1Nh4XS0OWIzuTlkGz6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw4ZCMkMqb0AQLjXGOZ9t0j4tBQyEmdisgCi8ZIZET0=;
 b=E7oz+P4RC4DKaPyD467As/c9l0YqyPFUekRDBFwF02qWssATsXVDKpT9xSKbqDJD9HCiNvGwHZXHGXIus0+kXS6wIH4GdHG4YU1RN+7J6I5dbav0ihHKhdxmCIRbS3GL8fGzD5aYbiP1+wY6KmKAJQbLxOrLztgLuZvNgzoApOM=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:27 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/14] dmaengine: dw-edma-pcie: Rename vsec_data to dma_data
Date: Fri, 10 Jul 2026 17:15:12 +0900
Message-ID: <20260710081518.2394357-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 32aafd80-52ea-469d-7814-08dede5b6649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|6133799003|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	xFc0V4F80i4tMnHPo/MeIbF7BTla6v2D6DsAgUgJjJmr5VhJC5tM1f52jax7LgeFs8OUPuTG668j4jMNOqPw41n3rkMgnKWkT1j9TJ7yQV5lxcc5ANBigqFb6i0w/oR49q/mAt4/IOj0atjN1HyzZYzRO4CTlaefbY4URgrkuaPQF6V/1U43PBGsNR0ATjJoJMovCPlZVOelfXvcQ9KbOQYTDGmSfxq90pqPQc5FqYFsU9u1qemZhgdDUoCNEjN5Wvls/jFR+Hseie2OQrOHMdHMsthPUlEGsyPlcPNBEavUjWNr641H7MsxHG7OmI1w3MpRfsJfyNe40jKP3tHNxBroe9F444UzJVB61d36gUNpZZUdJoVGQ/VLcOGYx+wVBH9SxHG1TZUDKZr7Z0cIsexDB56kKGUOo+XcLhx5ztO10CA7/h0pZQnGPlkPcWCGS/KMO23tXa9oI9wJRx8Hyp+YQVGl7vAnRR6kPT1IjocLlPR8EDlSa9Ha7a4jTKE2ETaYJmLdo9//iBbmbSPCs3hfCGYHZha5Ab8ifC1FhwdWxiwcILKDTht8bTuPtIlvOtn0FvZDv1m7aokPmV9HhP6Iaus/wz89Bqy+15OCnCWROg7HesyawLUOOIlLMeRm2lSMro6v3cAG7JHOFPMVXSTwI5lNQj63/0MVqNigO4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9o6MwRN/aeNw42GztHF/yeuOZqZuk+f2LT5PRKg+rSt4sYHS3YV5qNIyC9+x?=
 =?us-ascii?Q?tacF56wW6oB4ks1Vz74nzBnY/3gSK2vja9sQIehcQ7IjDf0WNbuBVXU2VbRz?=
 =?us-ascii?Q?0X4NMgDQcucg2ILBH+Qp+vE1WGNw0yfdSI5xLSmn1MQcCo2+m/mE/mxnBD+W?=
 =?us-ascii?Q?B6kYUem4QzY27xTpZcMpbcDXdAOAxOmAyGnB0/A8EjcnS4R7U/7MedH6MzxB?=
 =?us-ascii?Q?y1KN/rJ8gX8uRcV6gYmqMIw7XvxxR1NqnnPf9UbgnWmVwSK1evoiMG/+BRCn?=
 =?us-ascii?Q?nagDj9miBZtn9prhT9VSE9y/dfOTdyLGeYuKTCFnN/VfF5qjZhOeite/yOec?=
 =?us-ascii?Q?vNFIyBjZE/3KSt9NCTRkvsrLnEsOEZhfcTHnaPgAsoHCHtVjEBzixDAOLbnc?=
 =?us-ascii?Q?0SEDv9Csrwc9F9K+qhKs2Gr5y1JvreVDNGk4iWftMCbGdkcB21XHwHm+OfUe?=
 =?us-ascii?Q?isW3p/ODXJjczjx0UZLlTsANyrdHUTa5CANyyzgCiTf3EAfcVCDsBt28G13t?=
 =?us-ascii?Q?fGVzwLvGzbCdo8gqx6Ljhg7ZspFOV0X0I4OjCLrtJQp6wLiXU/zUsFj+Gu9w?=
 =?us-ascii?Q?HFomF+2OtUe8iui8QtoLqc4TFV5I1XWvxsMXsweeCC4ql4sWs24yhd/iKUMF?=
 =?us-ascii?Q?wFS3WUTvJ1SM9voAcBB7okUyxvc6jRLLQR27FyixmUs9IIaZD1oepCdnk4lG?=
 =?us-ascii?Q?yf1H9yy9JumwaHLAJbfkraGVYXMihXD7iNjjfrL12UoD85BsP8kXmCbUS2hd?=
 =?us-ascii?Q?WNriAWZuJTZceHE9x28+v/PICrXcdbCJnutVAYb8K0z+JdRgusRQ4sKW1Im1?=
 =?us-ascii?Q?l5jHdX7wKQTRyb73HJZA2GZCvSxz1tweCXRO45tmyU6TRKYGPbM5eDtjubl+?=
 =?us-ascii?Q?rDGq9bIhcGASDysJwaHzdd2+M3O19+31sW9ht4/iw1poVddx3VnDpilB4FVp?=
 =?us-ascii?Q?1YgKlOpz9731bdrNteEpSaOBkgizfuv0VKiD8pAWAjcsCNI5WOfAmXludpXV?=
 =?us-ascii?Q?231oPpivtX74zh+QAdpL3MEdcjSl6n1oAWdCiz6D68Oa6tKMOBb1w73eBtLq?=
 =?us-ascii?Q?P3JRJcOxhVsxlhl+e1fNa3eU1Xc+lo6EDayki7N+qGhYnJd0H+9yuohVn9jJ?=
 =?us-ascii?Q?M9HZUQuzthRVmW8Cki5C/FVjLGR0Nc+B/kAMDg9QDd2FbUF6AnAvOPrnoenY?=
 =?us-ascii?Q?pzN3JpuDKgC5d+TqtdnAlVDvlinje7A8EzdZy2PlPkTmDx+shJ5aN0LEl+Bc?=
 =?us-ascii?Q?0+dyOP9Q3+cxIy6UxdMRCGvPA90Hk8v9ogLhAFX/2gpPThUO56vRDZ49q2aB?=
 =?us-ascii?Q?tYeciHvhuADw/KxB0nr5vg1dU22Z9ldRdIjAKvvG8/BaVtBbXJKjmZXsBlC8?=
 =?us-ascii?Q?ARrzSydYnXcq8hOVQtHOfnfP2sL1j5RrYZrYuHKlcWq71VlCIeLtv2iQM2VG?=
 =?us-ascii?Q?Hzv1rnyI1tDmHVkHQ5BaEWeNDE8V54mCRoF5Z+bnldEUWk7dTfVjlbkDWPKi?=
 =?us-ascii?Q?VjiDPo3VP4S2efBv6KtEuGbFhozmIZal1hBeL7N9doQmpwKdXAhbM67pR6sH?=
 =?us-ascii?Q?Fw4tL6MpvG0lqVfzNWphTd2OIKg80uNipKrY7pHZFZ0o/qRcQpoEKoBgGS+b?=
 =?us-ascii?Q?YyEWVHaETRXAj/EmbKTFj9Lxh2JpfWgVR/SHlAXYBa+vSm7zzEdj+ZwPhtmD?=
 =?us-ascii?Q?C35nnyVjA1XO0qvLBdB1xiQJZrrcBW0pgXMV+5l0Uv0perCLuoAx06OjO2Dw?=
 =?us-ascii?Q?l6J0N5YBPc2uEir0FhoZ0FNVoYRrM7cN/5mzwXCuHCuJLBojCaoU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aafd80-52ea-469d-7814-08dede5b6649
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:27.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZn3VafhMO9AmZesHR3VinqWarf7gwiledXwMqopLdfAJ6xz5Adi56xDRInSIsVk0Gy13O3OAadWB5biZu+viQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12291-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C54E73861F

dw_edma_pcie_probe() now obtains DMA layout data through device-specific
capability callbacks, not only from PCIe Vendor-Specific Extended
Capabilities. Rename the local data copy from vsec_data to dma_data
before adding endpoint DMA BAR metadata discovery, which does not rely
on VSEC.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 74 +++++++++++++++---------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 22e3efa6b365..41ebe96ed31a 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -390,9 +390,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!pdata)
 		return -ENODEV;
 
-	struct dw_edma_pcie_data *vsec_data __free(kfree) =
-		kmalloc_obj(*vsec_data);
-	if (!vsec_data)
+	struct dw_edma_pcie_data *dma_data __free(kfree) =
+		kmemdup(pdata, sizeof(*dma_data), GFP_KERNEL);
+	if (!dma_data)
 		return -ENOMEM;
 
 	/* Enable PCI device */
@@ -402,25 +402,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return err;
 	}
 
-	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
-
 	/* Let device-specific discovery override the static template data. */
 	if (!match->parse_caps)
 		return -EINVAL;
 
-	err = match->parse_caps(pdev, vsec_data);
+	err = match->parse_caps(pdev, dma_data);
 	if (err)
 		return err;
 
 	/* Mapping PCI BAR regions */
-	mask = BIT(vsec_data->rg.bar);
-	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
-		mask |= BIT(vsec_data->ll_wr[i].bar);
-		mask |= BIT(vsec_data->dt_wr[i].bar);
+	mask = BIT(dma_data->rg.bar);
+	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
+		mask |= BIT(dma_data->ll_wr[i].bar);
+		mask |= BIT(dma_data->dt_wr[i].bar);
 	}
-	for (i = 0; i < vsec_data->rd_ch_cnt; i++) {
-		mask |= BIT(vsec_data->ll_rd[i].bar);
-		mask |= BIT(vsec_data->dt_rd[i].bar);
+	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
+		mask |= BIT(dma_data->ll_rd[i].bar);
+		mask |= BIT(dma_data->dt_rd[i].bar);
 	}
 	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
@@ -443,7 +441,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	/* IRQs allocation */
-	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
+	nr_irqs = pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nr_irqs < 1) {
 		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
@@ -454,23 +452,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	/* Data structure initialization */
 	chip->dev = dev;
 
-	chip->mf = vsec_data->mf;
+	chip->mf = dma_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
-	chip->cfg_non_ll = vsec_data->cfg_non_ll;
+	chip->cfg_non_ll = dma_data->cfg_non_ll;
 
-	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
-	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
+	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
+	chip->ll_rd_cnt = dma_data->rd_ch_cnt;
 
-	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
+	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt && !vsec_data->cfg_non_ll; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !dma_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
-		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
-		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
+		struct dw_edma_block *ll_block = &dma_data->ll_wr[i];
+		struct dw_edma_block *dt_block = &dma_data->dt_wr[i];
 
 		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
 		if (!ll_region->vaddr.io)
@@ -478,7 +476,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, ll_block->bar);
+							 dma_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -488,16 +486,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, dt_block->bar);
+							 dma_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt && !vsec_data->cfg_non_ll; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !dma_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
-		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
-		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
+		struct dw_edma_block *ll_block = &dma_data->ll_rd[i];
+		struct dw_edma_block *dt_block = &dma_data->dt_rd[i];
 
 		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
 		if (!ll_region->vaddr.io)
@@ -505,7 +503,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, ll_block->bar);
+							 dma_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -515,7 +513,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, dt_block->bar);
+							 dma_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -533,31 +531,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
-		vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
+		dma_data->rg.bar, dma_data->rg.off, dma_data->rg.sz,
 		chip->reg_base);
 
 
 	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data->ll_wr[i].bar,
-			vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
+			i, dma_data->ll_wr[i].bar,
+			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
 			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data->dt_wr[i].bar,
-			vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
+			i, dma_data->dt_wr[i].bar,
+			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
 			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
 	}
 
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data->ll_rd[i].bar,
-			vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
+			i, dma_data->ll_rd[i].bar,
+			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
 			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data->dt_rd[i].bar,
-			vsec_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
+			i, dma_data->dt_rd[i].bar,
+			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
 			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
 	}
 
-- 
2.51.0


