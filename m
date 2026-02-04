Return-Path: <dmaengine+bounces-8718-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE4JJpRfg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8718-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:02:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7BE7CC4
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A01303C611
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398727F749;
	Wed,  4 Feb 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SqejZePW"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CF3D413D;
	Wed,  4 Feb 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216891; cv=fail; b=COoAFDa/MQYOA44s26AubwrUD9FIm5O+W0D6g277pTvPPfZ4wEzh6h4OHfCfLDGzQPKv1uWCsQkwzim0zBNpBvegmr9xdPdS5iSkC6dsAMHrpiAsB0VIy79+eqYGvqeCNtx0d0HHU/iGvgBx+g7e8uMEK7TiWhl0Moej2j5MQ5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216891; c=relaxed/simple;
	bh=ZFddtiIljJV8bPqalopfGap5kq/xyBhgA9QFpi+GzAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJsFXqZ6/1ZfzIL8pPrtpqNDfmLJ/oPXb0EFWSLBWfWv/skLdCXnYw1JROpu5u5hkbsb0Bw/iddUTm+AYkulAPMU3mdD6EWovB1jppToXpHa9jkWJ2kSQLinVAdUQSLcwnEWEmOLHR5dlsp8Gbl7YhKBcF1Kaq1oNZjXaE5u2Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SqejZePW; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5DKa9jPB3Y9yYRq58WgQHqSdoiEngtPN+kkP1PH+v2bdNxEBPv0CiJsnvrLg0lHEIwHkTxlhRk+rPRTKLc5urSY8U7fJC0QzjcQyHjaz4/llIXl7+8AZIaLHQ4HpvO62Ccm1wkgAWrVXn773p1aUjWQmd7YibA02DkDcZfH5Qn2VQbitSpmFEU8+0EpF/PXqS1kCFttfqbN4w/R404jUdwywNoXcAWChDPM/YGi8YsNfXZsdSR4qkfVxMVEfWTkaG/E4NR2nUhVG+oaXF4BfI8HyWBweYvleecemeMBLToC3xoS4Yp2R2Kun4bVfaVZLe9LZeBjA357oEH8OH5Egg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdygeLCEVrYabW1EEZ3BFK0qUUx6AbRgKmOsoz5Kl4w=;
 b=f+GcJorIMp5/krnhu/Ff47zBbe4yfg0BNtnkeMRrM7M98PvJ++i3opdaTfNYFcuYI9Ml6uX3NZUFF3Ljsq1SY6UaFoZGqZXkMSCtUVsXCbR2Ses3kAVKldJjHiygyPM4GdByZH/e9Rzb7ScJugBSHxrIc95g4ZVLFaAT/3Xmra5T7YudrElMhf2yGdNuXI6hQ7lyw6oYh4AG1ulZ7vXl/9b00+b58HThF+VEh2owCxZlfEJ1dOWLv8DfDP9MPXLz0IVnEfbBJJaigSA0n8Qr+hm5QXfcZaISlVzu7nyxP7IQ2/ivGDuu+EtBB+rabb/6BZvagCmnwkySTn+3lFBt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdygeLCEVrYabW1EEZ3BFK0qUUx6AbRgKmOsoz5Kl4w=;
 b=SqejZePW5PfYvaH4UPaWxiMG3LuzkH/u04NyeiGalAdOfsopHnUAegWTgPn63S7eWWL5wUFuOTBwSzAk6FL2e7t3AEcOkW47RQ3BBSfoPX7v/wT+KLJrsan7ydS9RMJIpN87T/EuHji8Xq+A42i36RyEd7dQukd+gEm6I2PcQFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:49 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
Date: Wed,  4 Feb 2026 23:54:30 +0900
Message-ID: <20260204145440.950609-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5ca156-7f9d-41fc-b2a0-08de63fd57fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xn3Ym6wdWNuGRMpSQ8u6V1I6I9Pb3XOVJYnn9bQps5BNzZNiFSafK4oS7Nd1?=
 =?us-ascii?Q?PpWbqFXXImvgeO2kTKvzSNHspCQjAaZf3Dj1yMMHAVD3wL7o9tF8uHRQ8eu8?=
 =?us-ascii?Q?nLzta2MmLsbNh+FYP3SkTU0vQMisSQRPAoji9UaFxlanZheFWU2mR9rqifzE?=
 =?us-ascii?Q?B89W37atnAnRuK2KMDbr3DVzidC5rke//lIPzQ41XZfhuwq9aHc8/+It6JHH?=
 =?us-ascii?Q?nZo5GLKqFzm3C6rT6Nm3nrqjRCe6kPK5qOXm3vJHxqYIXB6WyCAJqnqIw8/E?=
 =?us-ascii?Q?mFZj8y//9D004n+6s2/sTdtKViKmvevo+Ohmh2+tnwPvrKMUbzT1ATbA7J2Y?=
 =?us-ascii?Q?bZMI45aUo8AqaNiOrRQ3uDgjrxyPLyp8JKr12x95EHnX8NZcWwY1Cecj+RA1?=
 =?us-ascii?Q?JGDFD4B4uSqAgVPkl1zTftCQSz//WM8cfs+2q9WsWOnSNPBjyF3H3xkb03oz?=
 =?us-ascii?Q?jqwkVgmJrcMxmLK0AHI7lQa23XyS58VS/PUBNSlIi4IoHOJJIm76xOqIrxRm?=
 =?us-ascii?Q?Qs7rAjKsiNU6nrZ64DzOQYmluJtuCUh+qzBEMa4Q9MvH8NGcrybNZr7fIU2O?=
 =?us-ascii?Q?TmC/PHwZn05C9XdGFOaLrLp5B9rjTEvttDtUzw5k4uYRTQSQrO08ftI7YY6n?=
 =?us-ascii?Q?nT32smKhAT79eUD0UANWzdg5IRSFUMOVws5iYNd92d3+ogzQCSKr4w+v8Y6D?=
 =?us-ascii?Q?Nh0ZyymzIcBYqO6DmycfHx0kXTrEFktkkI6AcJtOh7cz2pSa0iWDlucn9DXk?=
 =?us-ascii?Q?mcO4XUkATRvlVnFppisno0Fwr3+lQ6HvbMSF/2DMPY20t18Hb8/ljA/cFg+m?=
 =?us-ascii?Q?TWdmZUe+fBGnPJRStd7tYoeb7PXkyYpixsPUKsJtYlvUUjdiweJAemKZZYkv?=
 =?us-ascii?Q?qbpeERkm42CqGJqDLW7l7wSCDDLtruCZ+8D6RX/A6N6Y92tvKzr7JOTb84f6?=
 =?us-ascii?Q?3tW2jH+G7OGO8gtBUG8g9gu/7tafjQx/QL2OdifIXs6mku0XgFfarJT1QDGq?=
 =?us-ascii?Q?Oa7TOic4Mu9XpGGO1u2h7wkAqrZh3ohajOEkCx7AY6rWZ+3WO3k+Z/SZwZp9?=
 =?us-ascii?Q?3skK/++3yuvleWUn/SOe9mUlgt6vOWQWVrS+J+YxhTXHhajbEpwAlRsgMMQp?=
 =?us-ascii?Q?un/cGc2WLRVfJIHE0xrA0QtMQM9LUFxVLQTtl9Mg7k2oJlPHRspkyn/bfUO2?=
 =?us-ascii?Q?KYM7VSA0gluEbrhYUV+HZ/ufufdwc3+MkBFUVC4pNzfwm4bW84x5+OGtH8eS?=
 =?us-ascii?Q?BtKB8R03iRZO2+vgaDhKuDS2M1n6OQiJqVUlNiVuWzMPH2KIqND0rdk4eEwP?=
 =?us-ascii?Q?IQb54cuaZWNzEjd3EYxbprIzIfQIf8vqOrPrmuxUPCOL4/PeU/J36u/1dwVW?=
 =?us-ascii?Q?8+Es9m/kbSBPv5IIxf/CyGnu/0I1CIQh/car6+LhC1QMZHcjl+3gecKVplpx?=
 =?us-ascii?Q?CY6clw6KprltP1b4eCrMKXsLOpbD/AIVJnAmQ3NW6CXg2w/DXhXfAW6dv3ae?=
 =?us-ascii?Q?4+DG9EkhTXyMAVcXrLo2g+jS4mjyjxatHVIL0kdSeG4nhmnz9ol5g1TNMtEG?=
 =?us-ascii?Q?1t9Hql4ZLkw5QRvoN3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjLN4u3PubgfYMziBcdmtV1rpr3JISEBj5YcLAc1fULT5038/2RvUEqhKzGp?=
 =?us-ascii?Q?CC6yFq/P6LzUahEY52NqGS+uueG4JrdvW1euIRnXNCUPDIJyQxEEAOgO4qp2?=
 =?us-ascii?Q?oKdHNuQGXLAc+XhGJLrTFmpuGdDCnmbwykzOBLanGPaYyKUuJWHsTxMKvBNk?=
 =?us-ascii?Q?m2U0AvjdUnvXF7DwrfV/fv+ShkJexiciKaUtKIWv5PEF0K+QM47LqphAcwd5?=
 =?us-ascii?Q?HTLz2LO65HY0P6Xg0VSfsgaPP11hRbG1JGsshSm+e4vTDjKz4QDf6aY6sZID?=
 =?us-ascii?Q?F+t+tZEoQOPf99Xf32ChJTyAxtjX2GiAfRS3z1yX9FALvHA9ntaG0M0vTD8H?=
 =?us-ascii?Q?Jzsy6urQoigH5vusDVCpEbW+UsbByR7izHzV2E7ujVU9QWM4dQmmr303GNiA?=
 =?us-ascii?Q?7vxTHo1NGm6g4CEO/rAlV79wNaQrb1soHyIpkfG5a2mQW03k1czsCe4L/Kzr?=
 =?us-ascii?Q?HgitGVuNe/rJpPIvfnkRYBWdOABlLmxuBtfJi4q5aYsOiWevvQWT8yX/aEo5?=
 =?us-ascii?Q?GQwngQ0ox7YXziY9u9Dsq3+3Zxe+sNBK8tVJF+kQ7SSIG9af243H728KlzmD?=
 =?us-ascii?Q?45QMyEmuCpceyO91K7MGRGxCxqtTRXMmzblhzAFxqfagbAS4DOh51FKfGvCK?=
 =?us-ascii?Q?Ji5l6KiaZgumcmj4JQ6QGUKI7dbl1tcUxcxPiV5rFlsaShvzULZ8RzybgeW3?=
 =?us-ascii?Q?jj+bJiq0czuWzbn5unmcD1gohm/UQlPVugdP/YnVhMlzOp9gFYKiKlCXjdCT?=
 =?us-ascii?Q?gvNsPQ79/FqPlt6uSoNMPo95WgDSU6iyg5XfTzJXQi9/rv6ZQ2SlGUp6hj4g?=
 =?us-ascii?Q?NB9FbiH5IR1z8EacUpkd+F7IxGyaIQFsGDRohL2faPbHpSyPL2KAdUq42aLj?=
 =?us-ascii?Q?AfhBpADVvb+ySthf4m5v5RWvnoyX5m1FYyc7w3d0uZxUsZmxhnLKRQLxemC1?=
 =?us-ascii?Q?DI+rdzZDXLoppMW/vvpcdc4DKyqGpF26uphPbRzPOfP/B4J5mSHoSRB6GinA?=
 =?us-ascii?Q?0nd+8slRii76GW1jyuTzpn2CAMn9IB/fxdRraPUxOFjHXTPndH1RX665bhA3?=
 =?us-ascii?Q?xpG9dLuoP1SsFPAyVn5xQSMOO3VkJ009pYyadB5CK8dZHVX7MTuYYlnMRpmd?=
 =?us-ascii?Q?TM2GjOm6fIKqmFXOsCiIExs74G3GXz3vNK583GCN0KFhsjnAwPBpf9Pf8e3D?=
 =?us-ascii?Q?k/6soVP/2XacNwVSLEG4WRS4TT/3kz2DRlhtQP3vIU1Uw1dtIdi+srHF3mOx?=
 =?us-ascii?Q?hFhdVfnKgUUjximTbKhvxkKZL7IhbABw1stFGpTOCq/y71w3gDXJLMolLUi9?=
 =?us-ascii?Q?VPXnQrbs3PwcftVYTj4N/CzNoeGU7/ZudI7fJZhqQCPT5DOHm8pnly7kZg1Y?=
 =?us-ascii?Q?zo2FxxbaGLRC0XeLBqIB6zwGRq5GMQJbfPStU95f4Lyvwdg4Qs3AwDGNoFo+?=
 =?us-ascii?Q?iVVnCjIfEJ0cZ7/I07sGBTJnQiKufA19OWkLkQmvB/8UXMPhuViWBgIMvIyP?=
 =?us-ascii?Q?kFQrjV+DltBxyuc9SQR6S1Q7QC3csP2FvpHB4NMH2FTO0KDb9nsL/T7TI8pq?=
 =?us-ascii?Q?3cVCEi4sojZSqusCg0goh5Xk+p6+NT+XiP+71aLt6+PAfAdlB+gqNWtSQS1a?=
 =?us-ascii?Q?AQXTaxEuGBn5D5BkavmZXwAeQiO/jWiYKrE6kio3ctSVr95lXu9mVzPesiC+?=
 =?us-ascii?Q?5vFHjI5OYwu93znY979YqTEE8kb2LW+pjhS/AxIjJHU84eIYc99At2Mz8oWK?=
 =?us-ascii?Q?L2ZO+YKtRsxwXOSzWExpq9R+H3oG4tfyc2vwrzVfPXPUuOMdAU9M?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5ca156-7f9d-41fc-b2a0-08de63fd57fe
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:48.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyFo/4WG9kMvoNYM6suic3rMPwLUrxk4IbpGSc/o8Erh8/PLBBqABvvj7HqsBK2o5bHcgrvQzSSjt1rxsuF/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8718-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EE7BE7CC4
X-Rspamd-Action: no action

Expose the DesignWare eDMA per-channel identifier (chan->id) via
dma_get_slave_caps(). Note that the id space is separated for each read
or write channels.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..38832d9447fd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -217,6 +217,7 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 		else
 			caps->directions = BIT(DMA_MEM_TO_DEV);
 	}
+	caps->hw_id = chan->id;
 }
 
 static int dw_edma_device_config(struct dma_chan *dchan,
-- 
2.51.0


