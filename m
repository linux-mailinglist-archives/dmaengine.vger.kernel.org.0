Return-Path: <dmaengine+bounces-9039-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLIGL18fnml+TgQAu9opvQ
	(envelope-from <dmaengine+bounces-9039-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 22:59:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD7218CFCE
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 22:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C406D3018BD9
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 21:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22914343D84;
	Tue, 24 Feb 2026 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TuxqIl/H"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547A2C11DD;
	Tue, 24 Feb 2026 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970397; cv=fail; b=r6dNMjf7NesAXfhGVJs8uhA0brzLRK0TdsDzGxYjtA7ce3HUGyFKwfZHNTmPivfJ1HkUZXqJMxxtFBEO10Y+WiX4DZYDEYkpNy4FvgQOqJIe658VJ2LS1Ej6JtumeS9goL89b+f3RQvrESIffY1+azUiNJXMxvAdCYxBquoIjzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970397; c=relaxed/simple;
	bh=rrwrUkCwSQYyS9IKkPJEr2lkII8kXhPuVfn8+QDJm1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qjQW7FOPR0jwZLK672duVS4KJgwvQPzQjHSFnQGPz5w+2HmVno13u0b/K+9sq/OOQQsHYiRe2TbLw0k/b9VfhHwIT8fPexBzREMR8i1HWw7pDsOqnE4cB7rSSsF/7xCsNWzDQ/UJdPFzg+ZlLnRFVPbPG/dy8kCN6vKD+G+GUvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TuxqIl/H; arc=fail smtp.client-ip=40.107.130.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdOmwHzdoiKUy697f7i1vtM2cQQ527UcpoQAaIVGuJyUM7xCKnCKV3Hd8u/QCMEupKyvBj/ZmJzef/UGcYi4JAdpjjIpm3Vz62e3cwQNI7kbJEmL0k8qHu+xWvFxQ7zFDjQJnnZRJQrx5h3BiI2JLrxbmTKozGMMDIvVELCrPfHezi2CTAFJeKj2IIVo4/gyJg3GFsvkse96ZEIxgTaz3ZClCyFHHkh4uYmR5x60Luk7oS+3aJ4mDjoyrxpC7pAO4lAbW745e0NfOqqpOuwLTzcJZIC8QQrkfTPCo0U3wy+NBxFooeo5LQ9jKusGJAX8fLFatZTiicbAeNeQRZdWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b9nB745oH7q+7LI9EmJYX3JQlDgr5BLlDHwdv7Uit4=;
 b=KZX7lvw49+/+ZEvcD4aaKqPN1z9T2UNxnrR8c9JLsddswYlSvflliwd6YBXeMXK1XP530F0B0YUBMEYRTpAOX+mu1ekkOtnMXPyB48dUQmlgw/VZiOG5jOQP048bFFrDEucsACyS7MJTwwCCcQxNLn5IRXI3mwVMuhTFL7ppzqXtA7pqEwWMY66n2Q1D1LmTPifGi4nO/hRNj+pBxHvWscB5ox+awAtwfVV7xDTU4pGj1W2C8tHQHfzm2T61fJny+atPYYg21dRdcLgGKgKe/O7xgQ4XPS46s40Nr/DLaSNrDQwb+HaZ+2rfBTUkETaDz1mmdZa38fSYhqxkLCRfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b9nB745oH7q+7LI9EmJYX3JQlDgr5BLlDHwdv7Uit4=;
 b=TuxqIl/HhKyDJCcKdUFJgUVvXlhty1pYS+Fd4alK2d4BQcqE3JKnv3rWz7LtP56UzKx5M4f+DRYrVHo2Thy273NGO/hu+rgQ+9xVKAaFow6yX0YNqzMCRjBD0qDpSZCZNWM+niwOW7lhSG7U2frVHGplNgmAfLZ93kBAfjIyzDCvhkko49zhcq1EbS+55d21LD/n0bfFKo7O4Tc2yFz2kXAgGDvQ+AQbP98/tvDe3YdTx8LwrEVxZOuIMdC7bmO72ml1vvJOfBpZJy6Ttf6pjHxImSS09RE9dvwe3IWL/D728o+kjuF3qa02jauK+dEoMJUjlJrX2t1voPYbLPABWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB12398.eurprd04.prod.outlook.com (2603:10a6:10:602::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Tue, 24 Feb
 2026 21:59:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 21:59:52 +0000
Date: Tue, 24 Feb 2026 16:59:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, jonathanh@nvidia.com, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	p.zabel@pengutronix.de, robh@kernel.org, thierry.reding@gmail.com,
	vkoul@kernel.org
Subject: Re: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
Message-ID: <aZ4fUGYouVOlYdL7@lizhi-Precision-Tower-5810>
References: <aZTG8af4O-wosg4N@lizhi-Precision-Tower-5810>
 <20260224062543.47660-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224062543.47660-1-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH8P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB12398:EE_
X-MS-Office365-Filtering-Correlation-Id: 6053be1f-5b1f-4e24-c949-08de73f0095b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xPrV9IYDgNHpmZQJuCEnqlbEAcMsj7IqGkS/MMXPQzqAGeL1XxHYnRpdrf8J?=
 =?us-ascii?Q?ED4lVIJ59E3gJgGgHpgraUC1Snmq2xpVfCVOhJOXjhtgGmQc6qKppoyrMGfA?=
 =?us-ascii?Q?QQqYPqWPTefNDSqi0LYoyRuKjHIJrV2wsElSCqHwuGaCHa/NMLOvljFS1Yf8?=
 =?us-ascii?Q?/vLUPAhhYN2tmV5X40tnXbKVgmlrlA9s48UKJlCab+mOonGKTtG+17cBS0SC?=
 =?us-ascii?Q?8Lk+f+Olt4eXnl2RH3ranrYIZCr3xQF4jmmJaJOjvx0LKmJEWe/Sk55Tl4bh?=
 =?us-ascii?Q?CwKbeU54eEoY/qFwhYv8BpJoc/yBseS4gXeINSLwcaLleYMO7WoK9DZC+XOb?=
 =?us-ascii?Q?CB+rSswDGpToiCO4fFVOsPHUNewJCwuzfpedkUEmBbcwXKNbQtAdAdNsKHKr?=
 =?us-ascii?Q?5BdVINxZmibNqnU7znDfj7DcT4uu0oAEzB2Zy6NNI/dG4hKM2v+y0c5cYXfn?=
 =?us-ascii?Q?Dv9GUm9pCrSxYTVz8Hp4e/HePbvEhzeLPm1Ik64uqvtfkEkr5zCQUOJooj2K?=
 =?us-ascii?Q?eDqaiJvRfQBATMq27p1RvNALxmm83fsNScBqEJkVd40zfdFQU1VA8W8dDJde?=
 =?us-ascii?Q?3EB3l+MrEGP9gOs6CeoGPmUaPtfUTUNf7iJU3SJwNFjfvIirPfOL2av6so84?=
 =?us-ascii?Q?PqSuwtLqsI+tAS168ku83yP5mdUOEaiiKf3Hyihq80upxWtq3gThlvUStp86?=
 =?us-ascii?Q?GnSLP97Mwg74pFXoiXGTLxtyQfwfFruampi9re0PwCObgIB40iUTRjQ5OCBR?=
 =?us-ascii?Q?muwe3r15S212zf/O+aUceEArPvNa/w3bXW7RbZswTMsMHiZt86yFPxN5neio?=
 =?us-ascii?Q?AKxLwRJvp6z6laTAlaRSa1DorFKr1iqz4ZNZI5CMeUI4sYuBKl4HDeeqwNew?=
 =?us-ascii?Q?nnt5USMtcivU+LEyqPbeK1dOaRqVnIYePbTweAEbFU5gh4j939LfVVJOL6vj?=
 =?us-ascii?Q?bE3tOVQDtFi5ePK1HLOGK4TIbuUv0VT1aLe/DAG2oYMJnSc5f+Z+88cYimmp?=
 =?us-ascii?Q?+Xcq51RHgPZArU+lON3Sh7haAvUUsf3Amb2AudmEbQx2R3BJ6BQ1IsjEBiV3?=
 =?us-ascii?Q?btcp5c6SWbCvzOLTmi3Vmilaf/kHMni6LoR6CNxoTHy3unJ1XfXHl6SwXalG?=
 =?us-ascii?Q?YmEGhoi/TuqN58n9OCIT9DkhcZHJusrDpVlf84CzIR8SOsl69CbShl7P4VQ1?=
 =?us-ascii?Q?I9iLmRW4CIDQTIqGdxfQbsguSRE/OlnW3+h55jv7ymJrZtSx7jYzlvhLmpSv?=
 =?us-ascii?Q?lCTzHcw8mW+5IZASpDqShfbwKwjGo6qWlYqYX/rIg3Xfb8ekuz36CUVoj/NE?=
 =?us-ascii?Q?HBr/GxCN9z5HN1wbLXJ5uz1KMCGYp92gL3sDEdM2wgqRr0rpBMiBUFn1IkK/?=
 =?us-ascii?Q?+CO+nACFUnUbPpG1bGzFasXV+P6paC7DkdUQu4W1BYQ/PlCpt7ZS7Wyx+Kfi?=
 =?us-ascii?Q?G0jCcLMdW4sdzufw8slGHpTEpglB2oiRcugoWDcgtpKWQFKy65KRmFhv7H9n?=
 =?us-ascii?Q?3r4qLSnXslBliep5+wUYrkAoLS4MbIvxp5bY1Kp01+JNwqJyV7gi+o350GDL?=
 =?us-ascii?Q?wd8RgeArwjuczwEAdNdZH+t2Wct2+ZYYF4ImVQqGY6/sBbaa+GMYyib64bc3?=
 =?us-ascii?Q?An0pSap4zOkE4oteFvGp8M4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+mF5n3RQ0yjXU59j9lkdFbWDvLCEN8X2fCDZV33EEYDUuDQ/ui339Zia2GLr?=
 =?us-ascii?Q?PSOA9IKdR1T1ZSlO3zthrAn4rXN8Qmh9hydHV0UAoeOBjg7zL7dbWlB6A9WE?=
 =?us-ascii?Q?hpfGjAbdlgXWZ82dZFTU1A7EGQCAacD5Xa3sLQ+C7FGsSEe3PRMxSs633S0p?=
 =?us-ascii?Q?bY1CL0gNTGXskm9IRYfCmR7RXaTrrn+SQ3sgrpwU2KWv4uWGtOuDRkJ9BPli?=
 =?us-ascii?Q?b/qekWK2gKX7KY/wx1TCZgUiMcttEQfIv9D+hCFYcJO9myDNDnI3N2E48uPZ?=
 =?us-ascii?Q?FDY/cX+iGL3gQmF0kn4SUnAA9tmmFrbF2vR38f5Rh0qhIuH6CGHff9maRJsX?=
 =?us-ascii?Q?RoUTlL2QeFw/mQdYZoo9sRde532He3YNrwHWJ3YJvYbPu6VRzZOQFDJA4DVQ?=
 =?us-ascii?Q?Nx8nI3gTrJf7XtLnCYegAeNkNkL1ZmPHkfAhYpRSZkAkpb/lcw32sZIu6v1+?=
 =?us-ascii?Q?PTB6U9HSCOjFm0RZlnes72fP5MxaQfuZZljUTCCQuTz9BK5SR1eondfPD3i4?=
 =?us-ascii?Q?wuXjUSIzljHYplTYQ1+ETL5zJGGSewr+9UgeQVJ5SJ2DiB9pkch/oYhrhk4O?=
 =?us-ascii?Q?Y2pERQyPjShRlQzpI/vNIFI5lJ5eioj//YojN9Lp+MtmD3YpF/kLpxNQfIeI?=
 =?us-ascii?Q?uhm08dpjP5zMVFdNcX7Hn+7SeqTqXX2j5feXM98Bp+OyN21OpiM+QL3+OBKs?=
 =?us-ascii?Q?3OEDnLsk1FSHm2x40fQPyIM5J+TWZbEnUMU8qgbtvt5TVBUSwSfAmpqQdlrd?=
 =?us-ascii?Q?5v1m3zPYyhXt36XKkPvUtxSeMRiTuGWR/pOkH6+zDP0F45o2f0XvbgZ2ApW4?=
 =?us-ascii?Q?duTwRwUMkGSCKi5H8QZ+/XoGiaM530tDHRa7J1GOzUWTLFwbATYNtPUKM8iJ?=
 =?us-ascii?Q?hFyWr/eg3S04WQJ7WplqP+MOlDNRr62EXRzgpUUC96BLhBcvDJLyL+keoqlY?=
 =?us-ascii?Q?+ieCs6VDqr/8l/D/8jm5h799PWS9JPnMzcvhWapzls1i8s7JrCa/2mKIL38p?=
 =?us-ascii?Q?oeb4JVk9Qx31RI7ELARa0ZcYj9WJslpObLEnTJKbJCvaKrr7AvqSVOqqlV3N?=
 =?us-ascii?Q?0iCljw9mo6EWjwXOOAMyzNHCpA/Pix66ph9UjRy2LV+OM5CrO2Q3vJBB9uV5?=
 =?us-ascii?Q?SQR8vLk/6iBwu0Q5BJZ40ZlvQxhZp5aHBUR+z5xCSfMqS1sQMKVAYbBwhECv?=
 =?us-ascii?Q?THr0Nsv0esxcbXIqfGxJ6xt+2zpHZuMPdHbFXakJqQ3RkeN8ghD6J9C/aycE?=
 =?us-ascii?Q?p8bq1mEh1dwHZaQ/X06zQ8fKXXhf9wH/2w+i9yDlPfPBPbLSjyhDfjaD3Z4e?=
 =?us-ascii?Q?tDK08oZFKN+lvU3SairYkrreWhg+kToUeyjMW5kaUrw9SfOJ1HLQVT0tSokJ?=
 =?us-ascii?Q?wych7bruHQ3TpVao7iEfzT6jfOksbZ08u/mFHK4FDr1kDccxYa8J+M9lA5UC?=
 =?us-ascii?Q?8UoEP6sVfHa4MS5yr2XtzfTY+ZYL89rQ7qt6kKPv2fpa0gYo0a9grhuBK1qZ?=
 =?us-ascii?Q?oFvH/s1bGMGMF0VHz7esyuI0vnPL+KOH5hVaC39WC74l3VPaj+9UGLjGwpG6?=
 =?us-ascii?Q?vyCxJGqeZl5ZdgSRdVHAUIOw5C8gY4LSxyVIEtZCjb8b73nFzQ95mW3GIDIH?=
 =?us-ascii?Q?jdkGCZph6lw4kJfH9AxrBKZqZQMOj1xp3mI4T/iuwmIX3weaWkGmyBEQcM7w?=
 =?us-ascii?Q?VcFDlpn4z24KEkh3HHIUd0JmMiQxmWN2XXhm9vkVQPyzDUfz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6053be1f-5b1f-4e24-c949-08de73f0095b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 21:59:52.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlLEexyj+JWzxdeSN/0Kskl8whNmisGmLcU3XN9Qvhi7kMYeGu39TdOd/OvYG2/WUTzwUUVnSBvw+p+68v3fVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB12398
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9039-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,pengutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 1FD7218CFCE
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:55:43AM +0530, Akhil R wrote:
> On Tue, 17 Feb 2026 14:52:17 -0500, Frank Li wrote:
> > On Tue, Feb 17, 2026 at 11:04:55PM +0530, Akhil R wrote:
> >> Use iommu-map, when provided, to get the stream ID to be programmed
> >> for each channel. Register each channel separately for allowing it
> >> to use a separate IOMMU domain for the transfer.
> >>
> >> Channels will continue to use the same global stream ID if iommu-map
> >> property is not present in the device tree.
> >>
> >> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> >> ---
> >>  drivers/dma/tegra186-gpc-dma.c | 62 +++++++++++++++++++++++++++-------
> >>  1 file changed, 49 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> >> index ce3b1dd52bb3..b8ca269fa3ba 100644
> >> --- a/drivers/dma/tegra186-gpc-dma.c
> >> +++ b/drivers/dma/tegra186-gpc-dma.c
> >> @@ -15,6 +15,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_dma.h>
> >> +#include <linux/of_device.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/reset.h>
> >>  #include <linux/slab.h>
> >> @@ -1403,9 +1404,12 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
> >>  static int tegra_dma_probe(struct platform_device *pdev)
> >>  {
> >>  	const struct tegra_dma_chip_data *cdata = NULL;
> >> +	struct tegra_dma_channel *tdc;
> >> +	struct tegra_dma *tdma;
> >> +	struct dma_chan *chan;
> >> +	bool use_iommu_map = false;
> >>  	unsigned int i;
> >>  	u32 stream_id;
> >> -	struct tegra_dma *tdma;
> >>  	int ret;
> >>
> >>  	cdata = of_device_get_match_data(&pdev->dev);
> >> @@ -1433,9 +1437,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
> >>
> >>  	tdma->dma_dev.dev = &pdev->dev;
> >>
> >> -	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
> >> -		dev_err(&pdev->dev, "Missing iommu stream-id\n");
> >> -		return -EINVAL;
> >> +	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
> >> +	if (!use_iommu_map) {
> >> +		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
> >> +			dev_err(&pdev->dev, "Missing iommu stream-id\n");
> >> +			return -EINVAL;
> >> +		}
> >>  	}
> >>
> >>  	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
> >> @@ -1449,7 +1456,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
> >>
> >>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
> >>  	for (i = 0; i < cdata->nr_channels; i++) {
> >> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
> >> +		tdc = &tdma->channels[i];
> >>
> >>  		/* Check for channel mask */
> >>  		if (!(tdma->chan_mask & BIT(i)))
> >> @@ -1469,10 +1476,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
> >>
> >>  		vchan_init(&tdc->vc, &tdma->dma_dev);
> >>  		tdc->vc.desc_free = tegra_dma_desc_free;
> >> -
> >> -		/* program stream-id for this channel */
> >> -		tegra_dma_program_sid(tdc, stream_id);
> >> -		tdc->stream_id = stream_id;
> >>  	}
> >>
> >>  	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
> >> @@ -1517,20 +1520,53 @@ static int tegra_dma_probe(struct platform_device *pdev)
> >>  		return ret;
> >>  	}
> >>
> >> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
> >> +		struct device *chdev = &chan->dev->device;
> >>
> > why no use
> > 	for (i = 0; i < cdata->nr_channels; i++) {
> > 		struct tegra_dma_channel *tdc = &tdma->channels[i];
>
> I thought this would ensure that we try to configure only the channels
> where the chan_dev and vchan are initialized. I understand that it is
> not probable in the current implementation that we will have channels
> which are uninitialized, but I felt this a better approach.
> Do you see any disadvantage in using the channels list?

not big issue, just strange, previous code use
for (i = 0; i < cdata->nr_channels; i++) {
}

why need enumerate it again and use difference method.

Frank
>
> >> +
> >> +		tdc = to_tegra_dma_chan(chan);
> >> +		if (use_iommu_map) {
> >> +			chdev->coherent_dma_mask = pdev->dev.coherent_dma_mask;
> >> +			chdev->dma_mask = &chdev->coherent_dma_mask;
> >> +			chdev->bus = pdev->dev.bus;
> >> +
> >> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
> >> +						  true, &tdc->id);
> >> +			if (ret) {
> >> +				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
> >> +					tdc->id, ret);
> >> +				goto err_unregister;
> >> +			}
> >> +
> >> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
> >> +				dev_err(chdev, "Failed to get stream ID for channel %d\n",
> >> +					tdc->id);
> >> +				goto err_unregister;
> >> +			}
> >> +
> >> +			chan->dev->chan_dma_dev = true;
> >> +		}
> >> +
> >> +		/* program stream-id for this channel */
> >> +		tegra_dma_program_sid(tdc, stream_id);
> >> +		tdc->stream_id = stream_id;
> >> +	}
> >> +
> >>  	ret = of_dma_controller_register(pdev->dev.of_node,
> >>  					 tegra_dma_of_xlate, tdma);
> >>  	if (ret < 0) {
> >>  		dev_err_probe(&pdev->dev, ret,
> >>  			      "GPC DMA OF registration failed\n");
> >> -
> >> -		dma_async_device_unregister(&tdma->dma_dev);
> >> -		return ret;
> >> +		goto err_unregister;
> >>  	}
> >>
> >> -	dev_info(&pdev->dev, "GPC DMA driver register %lu channels\n",
> >> +	dev_info(&pdev->dev, "GPC DMA driver registered %lu channels\n",
> >>  		 hweight_long(tdma->chan_mask));
> >>
> >>  	return 0;
> >> +
> >> +err_unregister:
> >> +	dma_async_device_unregister(&tdma->dma_dev);
> >
> > Can you use dmaenginem_async_device_register() to simple error path?
> >
> > Frank
>
> Agree. I will update it to use this function instead.
>
> >> +	return ret;
> >>  }
> >>
> >>  static void tegra_dma_remove(struct platform_device *pdev)
> >> --
>
> Regards,
> Akhil

