Return-Path: <dmaengine+bounces-7525-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E308CABC93
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 03:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F2293066356
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 01:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C24D26738C;
	Mon,  8 Dec 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="bBfJnXGz"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563B259CBF;
	Mon,  8 Dec 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159085; cv=fail; b=TwVoqzOjBrPezNmwgrd73gch7TUrTdzD9+CyVuXgCKPfldiHewrc/ZoacEqAnNJpV8YTrkAu7gl0H8YpVDdPDkhIs5NZx9I0559zaUJLPwKnoBGMy80KR3k6tP/FiSKDKtyn1KYYVJSh9RiWsqgrOyh7yXwjIUnQwDngK1JcaCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159085; c=relaxed/simple;
	bh=abuHsxGt52RMN6JSd6rD9hvB0PJaJhozCILLfP+R03o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKu8wLRfbMeCW4NRHqD+/M9/MurrLUfAkijSwOaqOvsEq8Lw2MIguR0iWZnYp2TgyaQA+6HbNwChOazY/wKW8ArRywQC32yZ7UBrxWMdb1s2HNlrqvZ7HdYaC92YRWq877jbCgnzjXtrPmCxpSuSwvOQo27MySskROfqcgyS4os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=bBfJnXGz; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKs+pFUG5BxSrA9g+ZsKgYaCRI8WYdA3K5Z1QQS54estFWh8o8465ddJ/nCVfj21++i1w9MXU47ApiWlyZLWRHcSRJoPnzWmELcNTIpYgbRixIUKS7Fqa8j/zkOAz86VKMvMtcUQdBhs5MDL64H7S4680U+taDnZ3iZ074TLcPLq/EMhEJhFW3QQtFB0V1Up+AJLCumKymrXExn13M/90u8aUteclsNNcWIE5gP3LP9mljIxXjjcxAOFLtShwdOtYj00AJiw/7suTDZFvJ/u1iGUTTRmg8HXH4rvEpTvKoIdTEOH6MEYa46CmHHKmjWoD6akpv+wTPmdW6PTXxel6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4Rw2UajG9+52npcMPQtWCOuQMVoipV9tW5FKDSQkZ4=;
 b=XrvHzlQ4bs4eTTZylPQCltm0F8RF7aYIsS0z3j8FB7ihWzMTIGU7UcqI864y0JmKT32HQRMn68KpzIRVxQzE/5wIQGBRBW4TaMCoYiNaKFik2D/5d74B0YeQiIe8+FoHANcVrE1jHa16i95kH3EXHKUKDaGVsR108YUQmI95XAKrdo4oPFyEVuscHxG+UtsLHCjd1hV9btJvvK1Eq5EuJy+ouDaxtmarSUKMk7BTAanRXqEXf7WBfmBkLBqEC/3ffh9qzZgq7T/xWOvk8h+0j5vllwnXiEsjXE4KubtzZ2j9J+Xgfsox3GTRTMhSYKO/yRfFofIHsVsdzmor7T1i3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4Rw2UajG9+52npcMPQtWCOuQMVoipV9tW5FKDSQkZ4=;
 b=bBfJnXGzIm+E0TloyPK89cq9vJ0NJ4IOVfVR2vFYhjslNAV8BT+31pdRXDRyrpnPjapK2VcxrdnRY2XMcPNXhdmTq+ym7rqvqM4eqavjex7ui0sKr3PB3ytBD49bA7vBOR04jHVKE4EYxgXk4n5AoNcuPZeOASvzdMRTla4eP2gIxhq0uo1XrVWdiC8kftnn4AQY925f8N2SJ3aS710UGpHN1ImxQYjrApdiZ3CwWMgJR1XPFXUC6ieVu0MJHqN2YgyYNBCZ6UD4DT5OtT9+En1ztBslg+UNZU+VkdxfDYSN0gK02mWxTB6GmgyIp5nHATzGZieCE30lPIr0a5oGPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA6PR03MB8010.namprd03.prod.outlook.com (2603:10b6:806:437::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 01:58:02 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 01:58:01 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 3/4] arm64: dts: intel: agilex5: Add dma-ranges, address and size cells to dma node
Date: Mon,  8 Dec 2025 09:57:44 +0800
Message-ID: <6ec1d147dc1e3f9778ee09a786e44498916ef33e.1764927089.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764927089.git.khairul.anuar.romli@altera.com>
References: <cover.1764927089.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA6PR03MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a691e4-694f-491d-e6b3-08de35fd3810
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rHVm+30JtY5P7BSJVkTbgoUvbp4gQyJr3vNvnV2sbIHOjY/QpcSPpejfVsDV?=
 =?us-ascii?Q?zbJYbvXvx+6zU4ycIuz8ZfpKKCW5xukY/zd2jR8w1JI7aw8igtOhWbyuAMxc?=
 =?us-ascii?Q?+KH0Y/wghkWYlnTCGFbofE6yywBZijIh7e8rfedPxfykVEPdPRjY5xXbrVjq?=
 =?us-ascii?Q?fLEarUoJeL0V/IrR0/ssIO2Zl7grxtSB3XoAl2Rf/d3gKifYsvN/P6B1D/ta?=
 =?us-ascii?Q?5Ek/01h1kmzih25Vy9x3lxkGhU7QDYLKf90XY27jaqXCepObFf7SlHAk2OwJ?=
 =?us-ascii?Q?wAeYv1D7tAENAkxLQVeCmQnK3qXPRQPBiCspeEvhTNfuYhxmFqV0gtPa1JPk?=
 =?us-ascii?Q?zQY5Eu2yjDXBNCQs2W1/dmH3oj4V26JmdJKyoNzRJd4gDC9KorNnv9vMih6J?=
 =?us-ascii?Q?64bwwS1is4g5UPIpyMrUVcwMn+dH9W2He0ktc6KLMmuWRMHaxtC3VJt71MqA?=
 =?us-ascii?Q?FiXFa7Zh3R95xx7xSF/+3zSnCGnDc+IMa2v3uPT0ZaTuiu3wmTi8E2PnUXJ4?=
 =?us-ascii?Q?VsStXO5u4pDOIXfglkxbCPxehnpl2p/BiBTLd4n+49M0vhaD8HV0b7XjYl6Z?=
 =?us-ascii?Q?9UwrIACg0LdMmISvbUynBe47eexUy+6XU1KIBTUTrKVQ6YlvBLX3MMvJ4MgY?=
 =?us-ascii?Q?/L9hNcKravNcLWNUvfzxQvaTVs1kYdS5RnPHLRPwSEk4EwwxeK+uCVQxpgv8?=
 =?us-ascii?Q?MQgV4Ml/tkLsS5YXQCwhBVUeZnJPY4wqXed13LGc/f5jndqrx251vfr3k0Fa?=
 =?us-ascii?Q?9AEcr6gNGWOQRlxCogeNBACqa/ZG9ebjmDXxrY6W5K1p1HsNIsUfzqphpxHh?=
 =?us-ascii?Q?5W5fCj5o2Q3FfVSDkDFB2iqKA4ro+hnldd810pLebmwMbxlSGDzblQAMN9lf?=
 =?us-ascii?Q?ST6UxBBUvy509LiS0SvMByM75rtvUkqh41tw5mn3hnLW812yqPFnLVv6OaOe?=
 =?us-ascii?Q?xgF18WKEof0eHeByxuG+OQ4nRwEojLZZ95l8JCOHGesFHDeEQhJORjGNGwK4?=
 =?us-ascii?Q?TaG4RRDaFBNSicB9kkAvyVrhzgoJETG50Myb0VIZXms/lNODVFLoE2OJoho+?=
 =?us-ascii?Q?6dqDkhfCDkDVDxKm0iC4dBVei+eLh2UkDT6FM5sR993ZsvpX7dXEvpNOQrbT?=
 =?us-ascii?Q?IR4s3aBn2DjROHRAqMT48p9H+C7yB8y0FYhRSYDP1JR7r27TfmQAPRUns8IG?=
 =?us-ascii?Q?GtOrUt60sPoIEqJoPJ39+Dd0A9fZJFjFo/QLbO5pzW9xEXxu3ZSF9i5c9S2y?=
 =?us-ascii?Q?FQwAyYqlEAfViWbfg7lt2YB+PYd9uGU0qS53KYiCfeKTroAf19RNFBa2XMh+?=
 =?us-ascii?Q?CE6AZWWwxSuWld8SFmkMDSPxVZkrRvzeVS59nWtMM6Tx9JoQp7hMqKepIIze?=
 =?us-ascii?Q?wq0P5HAeBaP0DzB0asixEmiFDJrLaciV9VXbwl7i80FvXIrgFhDediehvFfO?=
 =?us-ascii?Q?vxtmrK9Oz/pKriszmZ1C3HW0jtGSdxZfvN5TVrrMuaIu4kaLXx+3Mp3n+2Ie?=
 =?us-ascii?Q?AaRq2A+l7qM9n2w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eShVHZbpXJr7Ufn47yjUGek40BIAsyepRMnKS+9qZwUgpfcaw/EU0xjeCtZQ?=
 =?us-ascii?Q?JF8PP9ZoolA4NxsHwjCB72MEjuMgqzw5lSyCEicqwXaGlldIW9VFFZPJjLDB?=
 =?us-ascii?Q?YEzzQGg2TEqMh5ZBYdXl+kHJ6b0aVfRy7bKv87+5ybVDjKfM9QKKZdRjjP7N?=
 =?us-ascii?Q?QxxiuzBrG/YOSQaAuzpHNybeMuYXLu8JSB3hK5mbkIlNHsleo1OsVeWY2u5Q?=
 =?us-ascii?Q?vBJrznxvlKZHb9gQjmo/xB5truD+m/JOr3rrVjZk6qx7Ac2TPwW7mmbKnd9c?=
 =?us-ascii?Q?Gd7oErzqakjMSflAiPj72Czrgr8tf0YXq0QSqOMd/Kla+RN+1UBmN0I2sFnH?=
 =?us-ascii?Q?dsrmwRFYuatCvYs4rJLviUZJb5FzmutsvvmBXPasjNGcc8xa9soZqPEVYfa2?=
 =?us-ascii?Q?GgjCOqYIzYT4HOkP1uakrSEGskWMUAUuLcTup0y9OvSttJokgRlKRIz2Ma2z?=
 =?us-ascii?Q?G03TeoUTRr8gDlW6+rqQpaBKXAmC8ff349qw+WXBmdaoWKEPaK9sN8y5oLd3?=
 =?us-ascii?Q?qAzYvKLB3FmNafq51AA2sypKHacvfbOHy/DS2l43ofDw3s3cJZxiQBHGMcT+?=
 =?us-ascii?Q?2305zG0OpRUPsPMtVcQiGftubpihaKl8GdnlcTeMEahSJr1USXP0lktyEDrH?=
 =?us-ascii?Q?3XQTQJthNOjqzMg2gApx+3GHyyTb1kmw/HhdH+fgu6LnZgv4cKemWkiOKK+3?=
 =?us-ascii?Q?qEzKJhq9ZnZ+yt9TZ+O/LAuXbYLWho9Uv9S7ICEVnQ8aFsYSAxWPPA1OR7/4?=
 =?us-ascii?Q?hGryRdkqw5eoe0Xb/m9qiJGURmqL3Rrock54fSvjOR+3p4ceFts65Im2a3QW?=
 =?us-ascii?Q?VhY8rsx3f6Yv6c967hKZDvP2vY2TDJ07bR+5GN1IoM6on4Ui4/XLv7iCa51d?=
 =?us-ascii?Q?8T46emucIRJP9Reck/N9EBNsihtW3eF7NRsr9xbuNb5WJOm1MpXyKi3xSZxF?=
 =?us-ascii?Q?K0D5LK/Lsung8AYNVUr3HSvntzB4kj7dGlCNjLg+XiAl572eKBQZVLNz2+rg?=
 =?us-ascii?Q?CTdn8sN7cUEnHUNm1g4xwuA/qnhegkrWUpr+W3wt1RYJkZgI+EGrycOTYlEc?=
 =?us-ascii?Q?SKACrxQIPX8K93C82TRVplXlEO4XlgdpuAieWAHjwGRt8QdS8bMsoW/ahDpt?=
 =?us-ascii?Q?tslY4VfWbq7rrfL2gPD5YnbHOSn9YaIAXAOd+bhE38ixITdAetkT3745/U2l?=
 =?us-ascii?Q?yQW2UwrYSg5KJBKIdXssdImDgyJ8WvddxRu6bd4eh64xoaIahZ0mPPnl5eb8?=
 =?us-ascii?Q?2YiTKgyv0odivv1ngDovI3DerXP53yq7M7bIvd9mVQbN0e1sqfREDheKbfEG?=
 =?us-ascii?Q?wKLg4Lr++hNY2L6kYY8jWDFXjObeKAvq1oy0/keiJm/52ZN+Ntxyr+GPhIyY?=
 =?us-ascii?Q?uFZGPsunVZWV0VVs7tDOdimp7xrIS68ONlzDVvhfQwHOCmOwbWNj4X6e5r4E?=
 =?us-ascii?Q?PXgMCav/1cQ6v17gx7FLGFMxqD/47WYHiIV8+hrDwwYUI4KbPJ47KRQ3SNco?=
 =?us-ascii?Q?TTBCbC8yWGsxkmEzCSGpPFDNKcdm1FLj5HYa8KE8RIE1W310+o+U1QskneUW?=
 =?us-ascii?Q?uOR4v0bvoQj2o0TrfDna0WpTMY6gjb1DDhm2Irkpd0uQej5sRXvtIlRy+5PG?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a691e4-694f-491d-e6b3-08de35fd3810
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 01:58:01.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HObjpMCpU4ctxit8vwBlEN9kxxNGETuvPEyIodgFfUjQaHiAH5HEZH9UdOq2QSmyyhs8cvwi7j+YIN13gh7jobs3Or+kWZe7p1Tkr8om/j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8010

Update the compatible string for the DMA controller nodes in the Agilex5
device tree from the generic "snps,axi-dma-1.01a" to the platform-specific
"altr,agilex5-axi-dma". Add fallback capability to ensure driver is able
to initialize properly.

This change enables the use of platform-specific features and constraints
in the driver, such as setting a 40-bit DMA addressable mask through
dma-ranges, which is required for Agilex5. It also aligns with the updated
device tree bindings and driver support for this compatible string.

Address-cells and size-cells are also defined along with dma-ranges to
ensure of_base driver does not causing kernel panic during boot up.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Rename the from add platform specific to add dma-ranges, address
	  and size cells.
	- Define address-cells and size-cells for dmac0 and dmac1
	- Add dma-ranges for agilex5 for 40-bit
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 06f98667499b..1983869274e7 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -336,8 +336,11 @@ ocram: sram@0 {
 		};
 
 		dmac0: dma-controller@10db0000 {
-			compatible = "snps,axi-dma-1.01a";
+			compatible = "altr,agilex5-axi-dma",
+				     "snps,axi-dma-1.01a";
 			reg = <0x10db0000 0x500>;
+			#address-cells = <1>;
+			#size-cells = <2>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>,
 				 <&clkmgr AGILEX5_L4_MP_CLK>;
 			clock-names = "core-clk", "cfgr-clk";
@@ -351,11 +354,15 @@ dmac0: dma-controller@10db0000 {
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
 			iommus = <&smmu 8>;
+			dma-ranges = <0x00 0x00 0x00000100 0x00000000>;
 		};
 
 		dmac1: dma-controller@10dc0000 {
-			compatible = "snps,axi-dma-1.01a";
+			compatible = "altr,agilex5-axi-dma",
+				     "snps,axi-dma-1.01a";
 			reg = <0x10dc0000 0x500>;
+			#address-cells = <1>;
+			#size-cells = <2>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>,
 				 <&clkmgr AGILEX5_L4_MP_CLK>;
 			clock-names = "core-clk", "cfgr-clk";
@@ -369,6 +376,7 @@ dmac1: dma-controller@10dc0000 {
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
 			iommus = <&smmu 9>;
+			dma-ranges = <0x00 0x00 0x00000100 0x00000000>;
 		};
 
 		rst: rstmgr@10d11000 {
-- 
2.43.7


