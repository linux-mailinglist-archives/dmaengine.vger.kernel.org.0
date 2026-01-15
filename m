Return-Path: <dmaengine+bounces-8283-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D007ED25A72
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED2A31102B6
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9793BC4D7;
	Thu, 15 Jan 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jxe6OxvA"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661123AA1AE;
	Thu, 15 Jan 2026 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493262; cv=fail; b=khYFtR9ASab1XOuB+YbIEhEQ4301u1OiJGSVcwInYlA4xnCuufuaTdwMR5rj9VAkInlfb0veubSBkxCE8aMJP/3B+G8aFEgYgh172a3tlKyyj9cr6EZRW20JTjaEdvnDxZGUwxlC5j15mg+Ygd/Yw+VLbAHKYIhN2B9lyaVaf6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493262; c=relaxed/simple;
	bh=j1Zvke9y+UupBv90BWzFcLi5vWTea+WzvafxMR8YPq0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KxB7LPRUQCUCSxdMGfNY8X1B4wRmwYNs/eKYQX9W1/tGLkHnCYMJzPjxo11NuBhd67YAj+ohxwTlynn4m0hXFAkXlVp+qvE7RlbOrISncHKPXGR50sRhLRdYnwVb5rW2yyrbD+wYCYYLJPRWc76haFSy/2B25gym74n3hxQriNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jxe6OxvA; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb3RTqkckUVhOMlP+f03hyaVp6FNA5a6UwZ3v7rbqLWmfLEJ82Xdnql+CfjWvvQ6NVh1pnvohk3xs7IwpycNg7KO2syBXFKS8I2A2d4jOCOFzJeFRNohirte6uUJ/MP/VCA9lmhNRCdGfaC7WBkTqeRD/c2kzEfPyoa8zY0o8yy7kTo0tJYRjxQ3kCsYriNUQhp+Doc+0BowQPKY0DUMEGFQah4ukZvdE/G1+BkCsTBZAcy/NggCIffH+Us0k5+ymz69d16ffAFZJ/rM3NsqKf7rSkUc1lMD/mZUL9uWjv4MKFKAY3daidao4S5Z+iga7ES7qqan2Du0iJRfwq8PnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKiWqs5tjqYiOIreL+q7Fckc9oEcq3JO75rjb7kYBds=;
 b=eP4UyIdJJf72sWXGF4ZgZgfm/V6sqICCooGAhBYC3KKrDjEC4ncgUt+Ki0FNYnEoqQlY/2C3B+VW9TsWRJUHKw7mseFUK3qojzCJz70Z2OAZYfBZaGqFWqiGa604ZPacySNXgkSgOCN02VUFiiI7UrLEuBLDkykUkCfhVv0X1fjwmrhMSnhkpQiDR2SUMJ8h4O9BOxRKIS1YPEd5i5EQj+t41wRSUodHIQqDV6hoYe6jCyPVN4HifVIFUki2QiVyqlwR76kehR69MnMVhidthhw5VI3sNEWg4q2udAFers+2FKJ/Pkgqci1uCEQLJuQIkEYwUyircZZiWUO4azyzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKiWqs5tjqYiOIreL+q7Fckc9oEcq3JO75rjb7kYBds=;
 b=jxe6OxvAuYBoK+gyk1Xvdu7jSjhd1ZHp0bSZGoN8ejFntkNIBxd6hMx/xWy/ISDsf3LVsMIVPerXykjuV690EyznK7jM9Wy3sGJpyAfzniMRu7EONd+A8zsHCmHCQ9LAygt8v7cB0proWtX3+Ut64+IY3N4l2FkxIjaXhsFeJdSxIJ4faLfHqziXQHGF+PbwF4ShNs8aQOgGbi9lLemPgyNQa/F0LV4UL+Un/k1bfBu0Xe5ovofSpwk4wTQM9OhtwLMaK2FmtGWpS6/PGlfu7H8U7Ep1OdKcJoZ2i+DThImXpxsfVK1LcYD+ObJjHLqYAZFizAVrx7i0HkLcRy50qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:35 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:48 -0500
Subject: [PATCH v2 09/13] dmaengine: imx-sdma: Use managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-9-0e1638939d03@nxp.com>
References: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
In-Reply-To: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=2538;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=j1Zvke9y+UupBv90BWzFcLi5vWTea+WzvafxMR8YPq0=;
 b=/Q4G0yFbz+392noQ113TR4J59UEyUAeZcM0Ac6zbJXIQBMNOWmsoNlr/+Tqi3OoQvVCDRc0SZ
 QSE4Y5jj2/RDr6u1U7T7q4iTkUz83o5FY+a2s5JGITSlFdr/t+doY7u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c5f6ea-6800-435a-a541-08de54503231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dktjRk1nNW9PZUlMUE96MjErQTg2K3MzWTJrSTRsV2xNSDI1UkRrYVhsWmg3?=
 =?utf-8?B?bTRxWm1yVHlFVW9odTB3ci9ORU1Cdmc3SG5DdGRBUWZDelcxT2d1aG9HOTNU?=
 =?utf-8?B?eWJMZnQ3ZXdiRmsxdUg1dDFack04QXZVcTVQbnBEa05HZ0IwVndqYVhMRDIz?=
 =?utf-8?B?eFdRdlFhdWFhMGhNNG80Z1p3eHpTK2ttNlpTTlM4TVBiVEhDNXpIbXQwaEVw?=
 =?utf-8?B?L0lCWld1cHpaN0xudlVhN2J4MWNhK0drNWROL1F2Wmp1M2NXcXZlT3o5UkEy?=
 =?utf-8?B?VHMxNHVZd1NTUWpTc0h3RjdVUFpBRlRuQVVRQXNwWnlST0RTS3dyVTJ5dXZ3?=
 =?utf-8?B?S3pVUDNkZ09EbHlCTk9UTWVlNlZIa3FBd3hKaCtXdklXcytkeGpkbmhVY2xz?=
 =?utf-8?B?N3gxeXRuV3ZvUTducXkrNjRGdG5hay9ucnhCeEo2TmYzVTg2Q2pSVXR5M0Fo?=
 =?utf-8?B?Wit4ckVqQ1pDeW1JUHFOUCtGREhUelVGcDRNeG14Tjh1MmFCNWRQM3pmblpt?=
 =?utf-8?B?a0U1TEtSalg2dGdpWU9LYUFDUWc3dnRnSUFSVTJWL1ErREkrOUJrL2M5bHcr?=
 =?utf-8?B?VTZyU0p0a0ZVUEhHWDdFaCt2OHVzYTZaRUxkdGRsNGFDdlVXZS9NQzNqbHh5?=
 =?utf-8?B?QWpYazJKcllCRkkrQWNqbjgxQ0k0YnY5Y1RWd0wxVnJtVG9VYzVRc0FHK2RG?=
 =?utf-8?B?S21WQ0R4TGJneFpLdVpIdWlCMThEdGZHT3RnZzZxZkxoRGhscmswVW5jNmVO?=
 =?utf-8?B?bTE3cUdjdUlhT3lrOGhTV0kxUzhqZXFOcmNsTVZJQWNlenQrYVFYdnNUSVVL?=
 =?utf-8?B?akgyM1AyOGxuRmdhelo4aC9sazJ0aXBGS0pyTEJndDQxSkFjVDN3QzY3Yklw?=
 =?utf-8?B?WEtrVmsycVc5R2tnM3grNFRMTUw5OVpZSSt2SGF4WGxDcFVkbWlzNzdic0I0?=
 =?utf-8?B?RDBBTlMrOERNRjlxL2FRb3NFVUovMlN5OElENjczRGZhZDlGUjlmL2RQU1A4?=
 =?utf-8?B?VndBQUtOazFTZ3lyU0NSSUtWSEdMNDMwZitxTHBSVDl5SEM2VVlrR2VzMjhM?=
 =?utf-8?B?TWFUcDN4bXVFRnFJOUgrS0dyUER5K2R6ZHlIWmp3TXpKaHN0K2d3Q29teGFu?=
 =?utf-8?B?aEx1ME1iOEpNMnNRSjNzcE5ma2w3aFpMWnQreWZud1F1c1IwN1c1d252bUlm?=
 =?utf-8?B?L3g3eEd0WS9CVnkrbEFZR01QNTg1b0JQZWY4RDJRWDFzS0ZObUtSVXpod2RV?=
 =?utf-8?B?MlViaGNvdEdyZkU5OXdEZWZ5clhuVUtOZXdVQjRsSUFZODVleGtPVkJFNlpQ?=
 =?utf-8?B?ZWhUd1NYdm0xSTBqZHR1S21uK3JKbDJMVnBHdi9raHFoblFZZDNuWlA1clBE?=
 =?utf-8?B?RUg1dVZuNmcwRnQzeW1oeHdSN2pvSlZLT0Z6enBkSXAxN2ZUS2hmbVJTN0FZ?=
 =?utf-8?B?Mm5BTFFtQUp0WTNqMzhTc1poUTI0ZC9XU1pzTFljNldJcW5XQmZ5YVh1NEFa?=
 =?utf-8?B?ZTZIZnZpeUl0Z1JuRWQ2SEhYUVhic0J1cFU4YVQwVTM1WWNBMjB6REdiK2xw?=
 =?utf-8?B?T3Q1OXZhdnJQeGQrcU1VME12ak1IVytOM2JydERXaDc2TlZleWNUMFBWb0VJ?=
 =?utf-8?B?dERNZWh3amcyUXJzdDFrczhKWE5LMWtuQ2M5bVVCN2x6M2lVV0lpQUxSL1pk?=
 =?utf-8?B?cnRlRnBMVklNblNCQ2NPditQMktHeDBmSHdoeVVpcC9hY0VndVdielBhejlP?=
 =?utf-8?B?MjNlRFMwblNKRXZWNUFpNGd5OGdnMWlxdnlYc1NJWHlsN1pxZVZPNVIvYThS?=
 =?utf-8?B?ZTNXSDJRejViUFM4dEdncVFaTzlTb0Y4TE0vUEhwRlBFekppdk1ZRkVTOTZ0?=
 =?utf-8?B?Um5KSjZKMDlYVHo5a3RGbERIMFpkZkVMZWZ2WHN4TjluOUFIZW4xSnF1eVd6?=
 =?utf-8?B?NTU2Vlp6Z09kTWh0b1pzU3VIbzBFZHBpeGNuRUtzRExocHQ4OXB2QmNLWGVk?=
 =?utf-8?B?bk03WjhycVZsQ2hxZlhoOS9nR1p4Yjg4ZExuckJuQVJsc09TRGJUV1U3ZC9n?=
 =?utf-8?B?blh6VXB3TU9PeGw5cmJZNXVUOFl3MWMxVm44eEUyd3FLbjA0WXFyS2NyYzJx?=
 =?utf-8?B?N1BjUVV4VXB0Mk9HQnNkYTRpV2NVTjFwZTlYdXl4UlA4VFU2aFVJWUFaYXRQ?=
 =?utf-8?Q?1oCgJJGV7h3DlKOnOyTYy0E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clo5b3BkbXgzcjIzWlhUamYwMzBwVTVwVFIzRTVkK3BGUUZCbnR5U2M5RmYv?=
 =?utf-8?B?Y3ExdCs4U3RXa2NuUWc0NW5XcE80T1Fab1EyVnNwU1BkY1dmUDhjZmJLbG5E?=
 =?utf-8?B?MlppcWNoa1JhOWszODFKcHVNOVJYQVIvUHZ3TWFIZnA3U29qcUxMMkR3Nm1Q?=
 =?utf-8?B?RDI2aEMwQnRPbExWTVA4d1B0WnZ5L0htK2x6OTRGM2NCVS9saHltNmluanNX?=
 =?utf-8?B?ZjV1Yk9Qb0NnUVoyRXN2RktFbjlwNnlheVFiWHhBUk0yVHRlTnN4Q0UwNngr?=
 =?utf-8?B?KzgwZnliWllJRDVOVm1PZTRYVW96dGIzSnB6ejlPVGFmUUcxTG50NGRnZTgv?=
 =?utf-8?B?NXg3R1R1RU5kaUtNM0poeGlVOHNiQXUyYlYvakVXa0EwU0NtS2U3OTQyWlV6?=
 =?utf-8?B?cElLM0l6MUJhSm9MVGUwSGZ2MHFmUzZpMkU1eGJrTDMxQTNTYmhXdzRESzUx?=
 =?utf-8?B?a3lOcXA0KzMxNGF1Y0FlNEx0L1FjU3dIWC9janlLVHB3R04zRWZyNHBJRTBZ?=
 =?utf-8?B?TU1FbHlwS3hIWXF3NlgyTnFJTGRRZklQZlpOWVI2QnN1MDk4Z21UWHNPczNN?=
 =?utf-8?B?MmYxQmd1ZFVadHQyQjFtRlBvOUFDbmxHN1pySWhoVkNpaEkwZk1tTTA5NnIr?=
 =?utf-8?B?dlE0eGhnMjRuRFJnVzRiT2lMT1hIZGNNZllwb0FXck12ZGVxZXJQRXdqbnBo?=
 =?utf-8?B?ek9VYXVLRG94MXRITm5OUkwxSis0M29lSXJpWnNxY1kyaS9YS1VMYkIrZEpY?=
 =?utf-8?B?SjVycHdJcTNxVEtpVlNRWW1YRmxJUWoyZit0eXVUL1pLdnN2ZWtodkNOWHJZ?=
 =?utf-8?B?OHA5OE9zMTZCbmx5NFVHbGY4dCtEOU00VVdIWTB6TmhlWkJSb0p3TktBNmMz?=
 =?utf-8?B?S3E3clBlS2xZck9US1hzVDMrNmY2RS9sVGdaQkR4V1ptNisxMjEzbGwyTzdT?=
 =?utf-8?B?US9sNHdjUmlRRWNjbmc4S0pYRW9nZUFpa3cvKzBveE44OUdKL241OUxvMTl6?=
 =?utf-8?B?NnRNTElDbExYWmNVM0huYjhBcElIMnNuelVqT21ETWg0MEsvR3Y3Y2ZxN0hZ?=
 =?utf-8?B?dDl6VUtVbk1qaXI4SkRCcHdaaW43WjRDVFBOTW8yajIxRHZQOFUybStwaDhP?=
 =?utf-8?B?NGpDY0UycW9TaDVacWpQUDJyT2FUdTZ5S0ZudDVOcHA2aEdXck5Sd3NSU2R5?=
 =?utf-8?B?Vkk1N0h5dkpFa1pLd3RLNENVMHZuL3F1a2M0NmdJTXFkN3pZN0RGNXlJaEJV?=
 =?utf-8?B?dFV1Q2poL1RqOWV6ZzJmUnF2bWd2cERUV3o5cUlCVVA5V3krL0ZURGRGMDha?=
 =?utf-8?B?cEtXbUxPeFdoRnZ0L3lBQUdyMEdQL1RucGdMS09kZXdEVkdvYTdhb1Vid3Bx?=
 =?utf-8?B?VUd1WkpQYVFsWlNVc1EzQ3prWWJNVlBTUEdRWnozWURDZWN2OTY0Y2pqOE5M?=
 =?utf-8?B?d21aQmNsVXJkTFI3bEh1SVlzOFRTTCs3L3BhWVVXY2wwcktLYUtxOWZVT0l0?=
 =?utf-8?B?RXJXNjNTdC9vU0ZYMkpYNFQ1aURZNmlNb2pxWktjY21UUkM0OWgxclplTlc2?=
 =?utf-8?B?UFpKekQ5VmdFNjdGSEFkelNXS0xsZXNNdDJqV3ZRQ3hGWmx4UTNxRnAvcTlX?=
 =?utf-8?B?Q0htL0RScVQ0eE5POElwTERoS2pHV3cvUTdvd0VrQ2dQb051QzlkMmlZRUla?=
 =?utf-8?B?L2hwaGp3ZkpTTUxNYkxnaUEyMzBrUW5ycUNkLzBBWHVlbnN0ZVdocXFHQmdq?=
 =?utf-8?B?eWdqUnBYdnNQcDVOUGhMWjFya3JRVEErT1pSWTliaERCR3IxZ1RjVnF4Rkdo?=
 =?utf-8?B?RCtITXpVaU1ROHNsc1lFRDZqLzBZWHhSa3ZpaGR0KzZ3bmtiZHVZSDRXTGYw?=
 =?utf-8?B?M2xEN3JuQ3dXcWlRRmNmSEw5T3JLd3Z4TXpZUU1NWnlzU3dJOWdzUktDYm5N?=
 =?utf-8?B?T3BGMW1raDJ1TXpnYXBab0VSTzVSMTcwQnFIM3JCV0V3WTVEenQ2a3BRajRs?=
 =?utf-8?B?TlN0dkVUUC9RNW9OOC9lNkp0eDlwRGNrQ0dwaVBVR0F1VFl3TVJyWHdSeGEy?=
 =?utf-8?B?akdqSUZLVEhNM1pTekNhZ3dHdm84cldOSzJxTktiT1F2K0xBa3dUNGNyNTBH?=
 =?utf-8?B?NitpV0p0YTVFTmppdTZSNTlheWlHZGFzL1lJN0FGR2dQc3ZuWVo0Ukc1ajFU?=
 =?utf-8?B?WGdoc1UrSU1WRDJYckM4WWdNTEtVcWpWa3JoWXB0Ry9YTEkvc1JFZEdIS2k0?=
 =?utf-8?B?cnY2VENzQk5BRGxyS29FL2xLZDgxeTg3S1pIRmhnNlVhQzFXanBkaDdGSGpG?=
 =?utf-8?B?bnJhM3JBTzgwaldlRStiTVJCRU5Qb0FKN1VLbFhkZ0NMNGRaV1JXdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c5f6ea-6800-435a-a541-08de54503231
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:35.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lnmXqys7xYkiHxu5KSBf3oxHjnY/jXdWUsPxUSwbdJvwS3ghmSUlxt946I03e8bRmj5Lgeg3sZ0XzdbbWgIqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628

Use managed API devm_kzalloc(), dmaenginem_async_device_register() and
devm_of_dma_controller_register() to simple code.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f7518f567ecd707575e73803a94c2c1d4762f3f4..95458ea188e3b0fc4e4f861df567c1c7524a3029 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2280,7 +2280,9 @@ static int sdma_probe(struct platform_device *pdev)
 
 	sdma->irq = irq;
 
-	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
+	sdma->script_addrs = devm_kzalloc(&pdev->dev,
+					  sizeof(*sdma->script_addrs),
+					  GFP_KERNEL);
 	if (!sdma->script_addrs)
 		return -ENOMEM;
 
@@ -2323,11 +2325,11 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = sdma_init(sdma);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	ret = sdma_event_remap(sdma);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
@@ -2353,17 +2355,18 @@ static int sdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sdma);
 
-	ret = dma_async_device_register(&sdma->dma_device);
+	ret = dmaenginem_async_device_register(&sdma->dma_device);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register\n");
-		goto err_init;
+		return ret;
 	}
 
 	if (np) {
-		ret = of_dma_controller_register(np, sdma_xlate, sdma);
+		ret = devm_of_dma_controller_register(&pdev->dev, np,
+						      sdma_xlate, sdma);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register controller\n");
-			goto err_register;
+			return ret;
 		}
 
 		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
@@ -2391,12 +2394,6 @@ static int sdma_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_register:
-	dma_async_device_unregister(&sdma->dma_device);
-err_init:
-	kfree(sdma->script_addrs);
-	return ret;
 }
 
 static void sdma_remove(struct platform_device *pdev)
@@ -2405,8 +2402,6 @@ static void sdma_remove(struct platform_device *pdev)
 	int i;
 
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
-	dma_async_device_unregister(&sdma->dma_device);
-	kfree(sdma->script_addrs);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];

-- 
2.34.1


