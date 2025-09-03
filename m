Return-Path: <dmaengine+bounces-6337-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32374B41457
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 07:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF18D3B8A5D
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 05:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AA2D5956;
	Wed,  3 Sep 2025 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CZXcfF3s"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8F2D3EDA;
	Wed,  3 Sep 2025 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756877270; cv=fail; b=AhLycTYDTH07juf3YGr7jC1xX0F8AMInqLMFXQHtQfVyyNhKXf5rBh4qufBc98oNSxbtXvN2Uxq7jPanVYS1x9bW0c6cF0HGjrzOE9GKg7hxl75l/4gO5XKOdN9ce7R8iwE5WeO9wg0hTaBzSLVSHLracb6G3xiBgiow6G87gaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756877270; c=relaxed/simple;
	bh=lqUoT3I/IhwFeEYaf7zpw3GFXCfxxC+fUZ8JLwbnWLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kEJXjvzb6RbC0PbxBqqV3Dd6k0Pe8FocAM1HkVu2n5OB/kQ2S1+RF3obOR7v9rr78nddQhj2JtKnRDioRcFjVLrIquwtVhi9udZ6Z9zl3u16jkA9VWF8xna22QEW9znlcLoJ4AYnc+soZ8stiaf95UapXSN4p2XXpjVuyHjyNks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CZXcfF3s; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtgTF0zk1lb5QSmsbdD+qYy4rOYqiAKPrQrIzTKxa5cA7DdR/3RTpv0iYYyCWuXcLGk9ZF4H76BpT4IePWtCaaf8Ev9EjlaTAgHd9DoSkUb0n0oZ4pIh5PRoiNFGZsR7J8MMl9JT752ZfinBn0+jdhve9dRl+CXiNtjT91O5+DF1LsuJWTO6zg/1OC3TsDSO05qoaMDLXfqansP/5Rqu3S4bwjQREGkCxwU31cjmPRrmsnfJ4iepOguLx6Vxc01+ZAy49temM1oeTCesI6EpOaLfB7OJoijr0kr4ed3Cie+5KTQxUs0BHg28uDwx0dGFFBiVoTwgPJ9R5Q8vzp8i3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqUoT3I/IhwFeEYaf7zpw3GFXCfxxC+fUZ8JLwbnWLc=;
 b=dfkVOztPKfPhp/2UdCCe2Gf57t8dDlQWXIll6iDJkQEil/vXJvrWNrCito5rUfAmJK9wDR5BSVgxHVddyvg5GIiHkAPcd53lVdEaJg67DmxeJA4sTD+pru11gSAWoWbp+Jha57j9qhSfjLqb9R2ctjQzMkFHEeNonkfSFDhYLK32dTAqPtfqnkM0GyR/zFmLjCDdsV52KEHpF3uB3XBqLibqjcT+DEsykDkWDAjHoUYZCSLr5WHA5dyPFtsNM3c6FTyv9qIUcCFvK08Wp4IiM9ezY50a7QNFAitpF/y+6c8JpRPHJHDSmNPwdThrpmgreqiGv+EgGsySKlmQyPrI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqUoT3I/IhwFeEYaf7zpw3GFXCfxxC+fUZ8JLwbnWLc=;
 b=CZXcfF3s7Yu5A+DTA71dW4Krofx5410SOV4W3bjTN55cEEgrx+fK62MeAwXvbPquz5PwmG/FSsrN6bIIuFydd1vTrp6p0JGYFS2EbvKA9C99uWmWNt5r2SaB6vzp1GpH5oC5AjHL5illPlM3PaGix1mTzmyYbVg7vS8ENDYR0EY=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 05:27:44 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 05:27:44 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "anthony@amarulasolutions.com" <anthony@amarulasolutions.com>, "Hou,
 Lizhi" <lizhi.hou@amd.com>, "Xu, Brian" <brian.xu@amd.com>, "Rampelli, Raj
 Kumar" <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] dmaengine: xilinx: xdma: Fix regmap max_register
Thread-Topic: [PATCH v3] dmaengine: xilinx: xdma: Fix regmap max_register
Thread-Index: AQHcHC3Cf5JBml4If0ijlKN22AN307SA6uVQ
Date: Wed, 3 Sep 2025 05:27:44 +0000
Message-ID:
 <MN0PR12MB5953DC881686CAFABCD13349B701A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250902-xdma-max-reg-v3-1-5fa37b8d2b15@amarulasolutions.com>
In-Reply-To: <20250902-xdma-max-reg-v3-1-5fa37b8d2b15@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-03T05:14:29.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CY5PR12MB6381:EE_
x-ms-office365-filtering-correlation-id: 10fb5715-f607-4e72-382f-08ddeaaa9c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vld4eDRDcEJYZFk0MzV6VDBjVVErSzdFakQzZzBtNnNjWmpGZmVnN3Z1WXMx?=
 =?utf-8?B?aWt6ckt4TEtjWGdocDU1emVzZk5tMzNXSHliT1IvRXdDejFYQzU2aG11dW5Z?=
 =?utf-8?B?RmQvU2xrTnFlNDM3eE96WXZmY2ZTby9jdHo1Q0Z4aEZGL2lqQ0RqdVFPdXh2?=
 =?utf-8?B?cVc5WU9sSWVqdGdUaHBmaUlaOExRSEJIaHpXNG9xR2pZbEN4S1J4dzRnZVZK?=
 =?utf-8?B?emV5RWxaVXZrWkRsM0JxeXp2dXpKbVJKSnA3aVc0elNrWk5ROUJLcVd2VjNx?=
 =?utf-8?B?SmlWMllNd2NWRnZYa1BhZnFRZURleFJKYVdxTmx1aFIwM3NBUDQ5YzJHdUxX?=
 =?utf-8?B?ZG9SMTV5SEZmSU11cThtMXZTZzdBUnpSNENLM2pkS0R1RGJ0dERiWlhremc5?=
 =?utf-8?B?UnNyTjQrSk94MC8wUEdiUkFOSmU2MHhhamI5bXcvZVFSbW9BWnpLS2wvWVVT?=
 =?utf-8?B?bDdEa3RoWWRLWTNsRytwbk96MU9rNmluTG5MQ3ZrVmlNSWsvN1RoOEI5MWs3?=
 =?utf-8?B?RzkrZjN6Z00yRDNPcGJXTFUzVVo2TFhoSHRtVElQOVBFR3c4RHJUVHZnNHcz?=
 =?utf-8?B?UFNCSVFHTjJrZFdkb2dKOWZlZ09aQmZwWjhiRVBOMnlTL3lNNTRZemd6dUp2?=
 =?utf-8?B?Uy8wbmpFSUJFS0s1c3RHbURSMjM4UDdHVUMxZ2JJU21wVFFmYVd6NWVkdU1o?=
 =?utf-8?B?M1FkdHZWbjE1c0RFSXYrUDZmendqN1ROM2cyNzVKMjd6cXNPMmlIbkY5MXRR?=
 =?utf-8?B?cld0bkpWaDVaTzdKdm9DMkdJa2VzeWw1bmxOS2Q0TU5Lak5PMVlleFU2M2J6?=
 =?utf-8?B?Yyt6czRLVElGTmxYeHJYbHMzeitWcTIyVVF0a2Yvazdzbmc3ZkJabnZQRG5R?=
 =?utf-8?B?NG1JU3hrS0lZY2dtaFpkRW90ay83MVhkcFNoL3d3YkE4QXJjem5TMk5WY3Rt?=
 =?utf-8?B?ZS9ubjZ2aWtiVUhmdzRiWklaR1N5a2doclh4RFh2VGVhWmc4S3lUb1kzQitm?=
 =?utf-8?B?dWltWGwwVXprQWdmbVlyT2c1NEQvaDFyZFlDaUFqdFUvcnBsc3dOTTR1RTg2?=
 =?utf-8?B?OWZ6aDZMY0MwcStheGdkTXRkQXpvUU9BMGhES01wQjR2NDBnT1Q5MlpWSzlV?=
 =?utf-8?B?M2RqUDR1V3IwdGVQUHdLcE9kY2MwODNzNnBmUFk2allmak5uUHAwbWo2c3ps?=
 =?utf-8?B?U2xmdWpmK2VGdUVuMHBYU3A4bUdjZTVKT0x0eWJZM1RyREZiK2FEZEY3Qnp6?=
 =?utf-8?B?RlZ0ZjRqS3lvL01hdUgzLzlBQVpxUG9LZVVtWjAweWNpR2ozdktlZGlKOHJO?=
 =?utf-8?B?dWU5UmNUV1NrL0FlS1QxeVpIUjdDUEU3d2ZFVDhYN2l5eXk0dTcyMUE3MUJH?=
 =?utf-8?B?U2QyQ0N2bzJ3ZityNnRXbU5DSlFUYTJuL3k5VHk5Lzh1RmlHUEJ0ZjRtNWlE?=
 =?utf-8?B?VXF2ZFNiVWZubUFiOHNiTnVuRkUwTnpKWGhmMEhlR2R0ZWZ5YkdYK05LZWFu?=
 =?utf-8?B?MmJocU5RVFI4YzZaaVVmKzhwWG9wYWE0OXFSM2RnQ3RmL0JkK1R2VkhXd3VJ?=
 =?utf-8?B?b2lJRnA5V3lZZENkSmJHN0VFOU83SElGNGVremFSOTF3YXAwdHhNSzVKUkZr?=
 =?utf-8?B?YzdsdERwcXA5cVZYMGhjZUxMVUhUemw0dnEzVG5zbERXdk45OVhxdDYxYzZq?=
 =?utf-8?B?MTUyWEZReVVDWmwweld4alJGOHdPYW90QXZHT3drUFp0WnVyc0xlQkJMTkZF?=
 =?utf-8?B?SllYczFhc05wWWF1Z1FjK2FYNjVJTnZPS3VzRGF4MDlzRnd0Slc4Tlc2MWJ4?=
 =?utf-8?B?NVRrOXpGd2xxc1crYXdNaEhqeG9TRnRSSTdXQThsRWFiMzdPQkhDdVJneE1a?=
 =?utf-8?B?VzNzQXBlWXQwTnhrbURpWXdBUWl0cXAzVVA4bjEvRkVyRm1vL2NrUEEvb1dr?=
 =?utf-8?B?Z0tiUEhHSUk1cDhhdklKdWF2VUxQVFdIbVNtdS9XSENxVmNzMnArUE5FMmh0?=
 =?utf-8?B?aE5QQ0tQRVFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk1ISkdwMllHeGt2L1BKVzRObjFDVGVydHNldzRiTWRyeEsrZVhoU1pTMmxr?=
 =?utf-8?B?QUowVXZYTU5Pc3F5WTFNeDg5cmdJemVpR2dEWDNNamtKUS80cUU4VjVQWitQ?=
 =?utf-8?B?aXkzSGVNc1ZpcXhpMFBUa1NKd0dHb0RYUWJ5Q3JEelFyR25GVzdsZ0tGNTIy?=
 =?utf-8?B?U1lkMlcyeHVweUhETFZaUjJSNzhEN3B0R2o1ejdRb1RFa1R6bnBmbzZHYzQw?=
 =?utf-8?B?UktMWml2YTJaY0FlQWdRc3ZuRm1EcS9GQnlUckNTT292VjRaK2JYU3psSC9W?=
 =?utf-8?B?RStTcFhYTnYxQjFWMlp4MnNramhQaXhGTWhKUDJlcys0VmZXQWs0YkM1NVZ4?=
 =?utf-8?B?WWQ3K2R1VkhaL0RwZFA4clRVbWxqQ3hmSzdacFdxTVBlLy8vNm5Ea3Q1aFpQ?=
 =?utf-8?B?eTZvb21weXZWQnpXN2R2aGtKMXlsdVZZWUxZTlJwWXNiRUNSTGZNTzc0MGR2?=
 =?utf-8?B?NWY3SEJyY0RBci8wZFMxNnNPRDdzMlZjdDB1RjQrUTZkQm9MckliSllza3BH?=
 =?utf-8?B?eThEanZwRDJyS3RDbzkzUzlaZ1BySGo5RTNRWmtlTnpTRFc5eFRQekYvdlpr?=
 =?utf-8?B?aXkvNm5sa05NQUs0U04zVmhYY2RwZ3h4dzg5Q0N3NmZSZmpjbldtZktSWE15?=
 =?utf-8?B?T0F0L1ZKQnVHd24yT3ZkTVVmQmVBalNEZFUrakxqRTY3QldvT3NuSFlLdkl5?=
 =?utf-8?B?NFp1QnZndnNvS0I0am9zUjN2c3RwNGtvbUFVOENacTJ1MGcxTjhXRU5iQUJC?=
 =?utf-8?B?aTRjMmdGYzI1OHZNdGVVN3hKcVlhemZVRVhYcXJXYkV5NkI0WGtFcldHZFB5?=
 =?utf-8?B?NHdFOGhoVlBkODYzbjh5bzdjTDYzTUlaYjhRRmtITDljc0p4TDBjRjlxU2Vv?=
 =?utf-8?B?b0FIOHRkTzZiLzlPeDJ4ajJFbWk2WkNDV1kwWUozOHlCQUJIS2xPeEFUSm1U?=
 =?utf-8?B?bVFCQ1g2TmVqaEZmNlJYQ0FCZXBJZVI2c25xQ1c3c2J5QTkzejBxMzN2cDVK?=
 =?utf-8?B?K3MrbEdIYi8zbWJOaXhVcTE3eTFrbHM0NlIyUWNNS1ZaK2t5bjFETEd2UXB5?=
 =?utf-8?B?ZWxDVDFTMkZkSlFNeFg1SVFNaUNrWDRydnkrMlB5TUJMYVhzQXF6Z0JERjd2?=
 =?utf-8?B?WlY2d01jOVZNOTZjU2tGdGJiRDFqcTBycWszSjNXakErTGRXZGZ4WTFHMDkr?=
 =?utf-8?B?Rm5xeWhnR3VyTGQrUkNKWWI2N3ZuOEx2a2xtQWlGVTVHRHIrdEFDSUl5K3Ey?=
 =?utf-8?B?NXhFU1lnTUJyYWFzb0pCcDAvUUpGMHVNTTRxMjRFdktKVmFzVytrTFNJRnc2?=
 =?utf-8?B?aGF6Y09GK2lPS2EzNVNnRitIMWxXdmc1ems2a1NNWnRydzZ0L1FueW1TRHRL?=
 =?utf-8?B?TENueVJJVzIxaTlFZnZLaGxETDh6N2dEZEFURUZ5aVk0OWZlQjhjbERpbzJX?=
 =?utf-8?B?b0h5NUQ3NjVhdFpOSWhxc09HWFRvc1k3TmN0M2IxendxZU5GMU1VNDEwUFlH?=
 =?utf-8?B?cmF3M2tKdjhnamNkbzB5NEkzbUJlR0g2ZFp0SldXNjlhTHkyWk5DK2xvZzh6?=
 =?utf-8?B?Rm8wTWpXTTNiZzU0Mm8vall4S2gzQzM0L2Y1WGxNV0RndWlFY0d5MVFwbkFB?=
 =?utf-8?B?dVBYcmVIbHBVVjFkTDNwaHNtcENNREZHMW01UVpBUWx4cFRLeXcwWDl6ZDBo?=
 =?utf-8?B?N1RlV3hZSXQ3QVQrRFlrOWJJRmMrcTloTUhwKzIzY2gxRmlYU1F5VGtKYmx1?=
 =?utf-8?B?bFNMK21VYXJJTWcvZFlocXo1ZzU2dWZza1g3L1Y0RXlDeE9yMHcweExDK3ZM?=
 =?utf-8?B?TDI0UEZpTXRNYUlvNSs2U1ZZbWhzVTlBR2tPQjloRjJGZGxnenZrSkpIRldp?=
 =?utf-8?B?UEI3OGVLWGgvV1ZXYnN1bTNUUHljOHBRNGs0dElQbVJuN2pLdW5taHhPWWpV?=
 =?utf-8?B?WmhodzFXVGZwNzZSZVR0N083V1IxSmV2YUdPMWZsc1JuWjdUc2FzKzVuYmk1?=
 =?utf-8?B?R1dUSmxOTXdHMzltc2hLMzJMelVtZE1nUlVBemlPZDRncW9uYWFLSnVMdjRr?=
 =?utf-8?B?OVpYSlB6eExIZnVyRmVaS2pIRThuRXlpQ1dqUTErdVhVT0doVmJzVG5tNU5J?=
 =?utf-8?Q?ng6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fb5715-f607-4e72-382f-08ddeaaa9c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 05:27:44.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McQ8XWJL+WsHFrnbqh/sN3T6lqpEid9Tc0uCZYN+yEDZtbwl+vFTsNzhsKP6l6cB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnRob255IEJyYW5kb24g
dmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK2FudGhvbnkuYW1hcnVsYXNvbHV0aW9ucy5jb21Aa2Vy
bmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDIsIDIwMjUgMTA6NDkgUE0NCj4g
VG86IEhvdSwgTGl6aGkgPGxpemhpLmhvdUBhbWQuY29tPjsgWHUsIEJyaWFuIDxicmlhbi54dUBh
bWQuY29tPjsgUmFtcGVsbGksDQo+IFJhaiBLdW1hciA8cmFqLmt1bWFyLnJhbXBlbGxpQGFtZC5j
b20+OyBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgU2ltZWssDQo+IE1pY2hhbCA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+DQo+IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBBbnRob255IEJyYW5kb24gPGFudGhvbnlAYW1hcnVsYXNvbHV0aW9ucy5jb20+
DQo+IFN1YmplY3Q6IFtQQVRDSCB2M10gZG1hZW5naW5lOiB4aWxpbng6IHhkbWE6IEZpeCByZWdt
YXAgbWF4X3JlZ2lzdGVyDQo+DQo+IEZyb206IEFudGhvbnkgQnJhbmRvbiA8YW50aG9ueUBhbWFy
dWxhc29sdXRpb25zLmNvbT4NCj4NCj4gVGhlIG1heF9yZWdpc3RlciBmaWVsZCBpcyBhc3NpZ25l
ZCB0aGUgc2l6ZSBvZiB0aGUgcmVnaXN0ZXIgbWVtb3J5IHJlZ2lvbiBpbnN0ZWFkIG9mDQo+IHRo
ZSBvZmZzZXQgb2YgdGhlIGxhc3QgcmVnaXN0ZXIuDQo+IFRoZSByZXN1bHQgaXMgdGhhdCByZWFk
aW5nIGZyb20gdGhlIHJlZ21hcCB2aWEgZGVidWdmcyBjYW4gY2F1c2UgYSBzZWdtZW50YXRpb24N
Cj4gZmF1bHQ6DQo+DQo+IHRhaWwgL3N5cy9rZXJuZWwvZGVidWcvcmVnbWFwL3hkbWEuMS5hdXRv
L3JlZ2lzdGVycw0KPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2
aXJ0dWFsIGFkZHJlc3MgZmZmZjgwMDA4MmY3MDAwMCBNZW0NCj4gYWJvcnQgaW5mbzoNCj4gICBF
U1IgPSAweDAwMDAwMDAwOTYwMDAwMDcNCj4gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwp
LCBJTCA9IDMyIGJpdHMNCj4gICBTRVQgPSAwLCBGblYgPSAwDQo+ICAgRUEgPSAwLCBTMVBUVyA9
IDANCj4gICBGU0MgPSAweDA3OiBsZXZlbCAzIHRyYW5zbGF0aW9uIGZhdWx0DQo+IFsuLi5dDQo+
IENhbGwgdHJhY2U6DQo+ICByZWdtYXBfbW1pb19yZWFkMzJsZSsweDEwLzB4MzANCj4gIF9yZWdt
YXBfYnVzX3JlZ19yZWFkKzB4NzQvMHhjMA0KPiAgX3JlZ21hcF9yZWFkKzB4NjgvMHgxOTgNCj4g
IHJlZ21hcF9yZWFkKzB4NTQvMHg4OA0KPiAgcmVnbWFwX3JlYWRfZGVidWdmcysweDE0MC8weDM4
MA0KPiAgcmVnbWFwX21hcF9yZWFkX2ZpbGUrMHgzMC8weDQ4DQo+ICBmdWxsX3Byb3h5X3JlYWQr
MHg2OC8weGM4DQo+ICB2ZnNfcmVhZCsweGNjLzB4MzEwDQo+ICBrc3lzX3JlYWQrMHg3Yy8weDEy
MA0KPiAgX19hcm02NF9zeXNfcmVhZCsweDI0LzB4NDANCj4gIGludm9rZV9zeXNjYWxsLmNvbnN0
cHJvcC4wKzB4NjQvMHgxMDgNCj4gIGRvX2VsMF9zdmMrMHhiMC8weGQ4DQo+ICBlbDBfc3ZjKzB4
MzgvMHgxMzANCj4gIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4MTIwLzB4MTM4DQo+ICBlbDB0XzY0
X3N5bmMrMHgxOTQvMHgxOTgNCj4gQ29kZTogYWExZTAzZTkgZDUwMzIwMWYgZjk0MDAwMDAgOGIy
MTQwMDAgKGI5NDAwMDAwKSAtLS1bIGVuZCB0cmFjZQ0KPiAwMDAwMDAwMDAwMDAwMDAwIF0tLS0N
Cj4gbm90ZTogdGFpbFsxMjE3XSBleGl0ZWQgd2l0aCBpcnFzIGRpc2FibGVkDQo+IG5vdGU6IHRh
aWxbMTIxN10gZXhpdGVkIHdpdGggcHJlZW1wdF9jb3VudCAxIFNlZ21lbnRhdGlvbiBmYXVsdA0K
Pg0KPiBGaXhlczogMTdjZTI1MjI2NmM3ICgiZG1hZW5naW5lOiB4aWxpbng6IHhkbWE6IEFkZCB4
aWxpbnggeGRtYSBkcml2ZXIiKQ0KPiBSZXZpZXdlZC1ieTogTGl6aGkgSG91IDxsaXpoaS5ob3VA
YW1kLmNvbT4NCg0KTml0IC0gUHV0ICByZXZpZXdlZC1ieSBhZnRlciBTb0IuDQoNCj4gU2lnbmVk
LW9mZi1ieTogQW50aG9ueSBCcmFuZG9uIDxhbnRob255QGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0K
DQpSZXZpZXdlZC1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUBh
bWQuY29tPg0KVGhhbmtzIQ0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEFkZCBGaXhl
cyB0YWcNCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwOTAx
LXhkbWEtbWF4LXJlZy12Mi0xLQ0KPiBmYTM3MjNhNzE4Y2RAYW1hcnVsYXNvbHV0aW9ucy5jb20N
Cj4NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBEZWZpbmUgbmV3IGNvbnN0YW50IFhETUFfTUFYX1JF
R19PRkZTRVQgYW5kIHVzZSB0aGF0Lg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyNTA5MDEteGRtYS1tYXgtcmVnLXYxLTEtDQo+IGI2YTA0NTYxZWRiMUBhbWFy
dWxhc29sdXRpb25zLmNvbQ0KPiAtLS0NCj4gIGRyaXZlcnMvZG1hL3hpbGlueC94ZG1hLXJlZ3Mu
aCB8IDEgKw0KPiAgZHJpdmVycy9kbWEveGlsaW54L3hkbWEuYyAgICAgIHwgMiArLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZG1hL3hpbGlueC94ZG1hLXJlZ3MuaCBiL2RyaXZlcnMvZG1hL3hpbGlu
eC94ZG1hLXJlZ3MuaCBpbmRleA0KPiA2YWQwODg3OGU5Mzg2MmI3NzBmZWJiNzFiOGJjODVlNjY4
MTM0MjhlLi43MGJjYTkyNjIxYWE0MWIwMzY3ZDFlMjM2YjMNCj4gZTI3NjM0NGEyNjMyMCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEveGlsaW54L3hkbWEtcmVncy5oDQo+ICsrKyBiL2RyaXZl
cnMvZG1hL3hpbGlueC94ZG1hLXJlZ3MuaA0KPiBAQCAtOSw2ICs5LDcgQEANCj4NCj4gIC8qIFRo
ZSBsZW5ndGggb2YgcmVnaXN0ZXIgc3BhY2UgZXhwb3NlZCB0byBob3N0ICovDQo+ICAjZGVmaW5l
IFhETUFfUkVHX1NQQUNFX0xFTiAgIDY1NTM2DQo+ICsjZGVmaW5lIFhETUFfTUFYX1JFR19PRkZT
RVQgIChYRE1BX1JFR19TUEFDRV9MRU4gLSA0KQ0KPg0KPiAgLyoNCj4gICAqIG1heGltdW0gbnVt
YmVyIG9mIERNQSBjaGFubmVscyBmb3IgZWFjaCBkaXJlY3Rpb246DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2RtYS94aWxpbngveGRtYS5jIGIvZHJpdmVycy9kbWEveGlsaW54L3hkbWEuYyBpbmRl
eA0KPiAwZDg4YjFhNjcwZTE0MmRhYzkwZDA5YzUxNTgwOWZhYTI0NzZhODE2Li41ZWNmODIyM2Mx
MTJlNDY4Yzc5Y2U2MzUzOThiDQo+IGEzOTNhNTM1YjllMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9kbWEveGlsaW54L3hkbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS94aWxpbngveGRtYS5jDQo+
IEBAIC0zOCw3ICszOCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyB4ZG1h
X3JlZ21hcF9jb25maWcgPSB7DQo+ICAgICAgIC5yZWdfYml0cyA9IDMyLA0KPiAgICAgICAudmFs
X2JpdHMgPSAzMiwNCj4gICAgICAgLnJlZ19zdHJpZGUgPSA0LA0KPiAtICAgICAubWF4X3JlZ2lz
dGVyID0gWERNQV9SRUdfU1BBQ0VfTEVOLA0KPiArICAgICAubWF4X3JlZ2lzdGVyID0gWERNQV9N
QVhfUkVHX09GRlNFVCwNCj4gIH07DQo+DQo+ICAvKioNCj4NCj4gLS0tDQo+IGJhc2UtY29tbWl0
OiBiMzIwNzg5ZDY4ODNjYzAwYWM3OGNlODNiY2NiZmU3ZWQ1OGFmY2YwDQo+IGNoYW5nZS1pZDog
MjAyNTA5MDEteGRtYS1tYXgtcmVnLTE2NDljNjQ1OTM1OA0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+
IC0tDQo+IEFudGhvbnkgQnJhbmRvbiA8YW50aG9ueUBhbWFydWxhc29sdXRpb25zLmNvbT4NCj4N
Cj4NCg0K

