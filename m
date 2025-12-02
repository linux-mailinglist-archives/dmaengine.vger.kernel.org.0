Return-Path: <dmaengine+bounces-7473-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19122C9D5D1
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 00:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F591349ADC
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029230FF26;
	Tue,  2 Dec 2025 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="oB90EXRH"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA230F953;
	Tue,  2 Dec 2025 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719268; cv=fail; b=HmA8IYZ5QY40eZdKr+/Id7kuUCqKtr1iWIIhtQMV3TqnS/zXN3YyuLHcLSLwhOWbRIZ3IWD1u4F1+MJ3iK4RwziOwNI9QN9CZOBvoqx9D8iYE8Mrtmud69cBxHxQ6f8cB4GJUKI7wWSzRuTNuGR8g/SlMEguJJhsFDRWlo6GOMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719268; c=relaxed/simple;
	bh=S/8Pins3hHOaA5ZJ5qnwNVcGTya20MMR8hnO5lIOZgE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LxQpBCs5kayLMb2pZmev7X12iOIG6FrNIMj9iGqnb5T0DcwRzvE2K4OeiFMOsQUEQMBBJdK3R5KlIi0V1GNi6OSIqJVFzF6bLNKZ/OSRjBCP8hl9o1joNmsZsk+VGMk4WU5e9dt+0czaGGk2gSzO7bb8zjWfC876OmnD5J7TFFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=oB90EXRH; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waZSn2UoeJXGKgJlIbdA7F5O6wSLOA9voWp1TTSUFmCiFajZK8sogAdjIOUNxRG/hCDvePDr+kqOHdmSKQACeT9ti/lJjQkEgHYxrTuaZy+GWrWe+uPZsLBn4CTRqoqDPJo8bZhb+PsCS/YkUrjvHmYQKm0WMvaFqkna3WTPyzuuzS+kQ8arwIH7XIBDeANhTCFOBZjnGC+A6HLS4W7Ed9OUq6/ggL4kds0HLJvGtYBh6v3ybo/d0DZNlICbjHmjkj+xgINEO6iZdId5kMHB2/Y8wwt3Tlct7Pt2ux24QyuRNz/yBAaZx13STcajKbCtX6AkWCVR59yPw3duIhILiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9akn1mqbP5HEeO/c9MkIDa3j1j9wjsT8SmPw+z2g/4=;
 b=te8Dk13O4wKrwU6OjCBp25HuIgujisFTTMKzNijEH8t9KGIITDLeKppu2XGPOJzNd9z7LzibewkXhFLR04txBKkij63k7fejSk7opkphMT+pytxjheOrekQaRsKuVB8WzQc6o8ThWzw/OUX8xUPLKxkDZevsMZq3bitjpcrqSLN7KBPBgt+wF4yStO4XyvdyGogfJ10KIhT2nkD6x+Z1k39mmrQlnqUkQpM5YCKnPFwL721Bd36ceOVXB044rbYl/aspkjRGIUjZUkv7LwTeaVrrOPaM1yYP10e3tMu79MYEVLYyPNyh3JCcnrCneSbrSGeB3DZDTwsLzsssZQJYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9akn1mqbP5HEeO/c9MkIDa3j1j9wjsT8SmPw+z2g/4=;
 b=oB90EXRHuI4N7e2Z4p7U5+vGdEiKD718vjS3Xa0D8Dx9ez+eWLj4xAf+AVPTvf0entIeRexK90JZreLkPQRvg54BN7T8y0RMn5Ib5HPoP521yio33B7HrX+FY0WBYRks9Krj45AUV5P/DtGmt4ThQs8d/nfNz0pfJiQp8Q4gEUK7QQ0tE+ihcvULbhmZ+MVYqrOGCFKRZMh5WtcE780OMeiPI2LLb7mo2161xBLXbLibUykFMn/N2SXh0lxyUF4rP/RJ9up/KTJg2L5lBNWo1d7nBCPwP4c3hXiksPGj/NFqCMZuhMJb+HnneR8wCPOQaTxxDw7ggPxxkqlkdug1Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA2PR03MB5689.namprd03.prod.outlook.com (2603:10b6:806:119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 23:47:43 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 23:47:42 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 0/3] Add dma-coherent property
Date: Wed,  3 Dec 2025 07:47:32 +0800
Message-ID: <cover.1764717960.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA2PR03MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cc5bb4-1e5a-44e1-51c3-08de31fd2f7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TitxZkkvYml0UmMwZ0xMNExNT2EwL1MycmdBaEFzaXovZDRZTXRMMndsenB0?=
 =?utf-8?B?M1BZT1RxWW9GdVFyUWNFTzN2bmpsbmpNdEE2dHQ1S2t6UjJJbzJZMHV6TVl4?=
 =?utf-8?B?dXhtcXE0S3Vmemk3d3psRVpwRHI5ZDYwV3N6N3FRYUFOWW8yZy9rWExEUmgw?=
 =?utf-8?B?SHNFVVV4V20va1lNbWlYeURXUXRvSUJkYytYSjRhWC9hcTFwUkpCQVBqU2FT?=
 =?utf-8?B?VnNVZ28yMDNVV0NEUGFpUk5VSDVqL0RoeVJSZEFkbTczelBlVFE1aFYvVkZG?=
 =?utf-8?B?aG8rYjQ2SWdQNFVDM24yQ1lVZmx1dG03YVEzb1VPa002ejNRcFZtWU1wbWhi?=
 =?utf-8?B?R2JRaStjTnRUVnhQTDdtNjI4bktVR0NnT1RYL21YOHNOMk4rVVpEQXU3ejJm?=
 =?utf-8?B?YmRmS25RUGlSY2xTWmptNlJVZzVSZGI0SnB4SHFLQ2FWTEVVTjJtRm1LT2M3?=
 =?utf-8?B?S1VVanljTmdpQk5ZNHBQcmhsWnZGZlhyTzFLTUNhOHF1RWVJemw3KzlBcFJs?=
 =?utf-8?B?T1lpc0lyZ05TTThKcFltM3V0OHpWZ014T1o0UnlOOXBIWmQ1a3BWUDdwbE8x?=
 =?utf-8?B?NnRlNXZmb2dYd1ZzRHlMYm0waEhwWTFjQktKbG4reFhLNUlUY0w1SFlnRnZl?=
 =?utf-8?B?TmFORy9xSnRXVVAzV0RUdmxzSEZBZy9Rd0plZ0hPd1BTWjM1M1B1WUF3cFhY?=
 =?utf-8?B?TklETUpVVGZsSCs2N3NNU1ExZ0dGZnAxYXZaUStjemRMN0NhbzJ1RXh4MXpJ?=
 =?utf-8?B?ZzR1Z1YwNmtRN2cyako0dWxrYmlSMjlubFBkbkw0aDJRQkMrc2x1bzltVHJm?=
 =?utf-8?B?U1oybkJqNTJyaVlSU0RJS3hsZWRVb050dFlramtsZHpDU0xDY0N0TEd5TWVC?=
 =?utf-8?B?d3hOMUdTUHdkWGhqKzlFMVFLM3Q5NHBIUXBZZVU0QmZwUHFERTlrYjhaeEl0?=
 =?utf-8?B?VC8vSFZxcHQ2c29DTzFwU05DdXI2dFJydDlqSkY3SnpvcFBjR0Z2U2ZkSFZw?=
 =?utf-8?B?ckxZODFuMGl3a3l1b3ZiaFpRNC9kU2Rrb1dVVEt5a0NRV0EyMWxlSkJmU2RE?=
 =?utf-8?B?S1BQN1lRYSs1V3JyRmZqbm1MYVQwNlIySU5JdEdoVVlzMXRLMmJzclZVdFpi?=
 =?utf-8?B?TW83MEl3dVMrMEs2N1RNcDQ3a3d6VWdJNVl1YUgrMys2OVRuQzJYdDhMYThB?=
 =?utf-8?B?bzRGY0RzL1BtekdJa3lTMTBjZDRqRXdzWXRyNUFVRTdFWk05R3JiZVVTQlRk?=
 =?utf-8?B?Q0pScHU5REJXRDhOL0tid1hOUzRPeDM4Uy9YQkVoK1JzUnpoK2M1YWRpK3dx?=
 =?utf-8?B?Ykc1UmNoNWozVW5iNFNyZzQrK0xlbmEvc1BNZzE4RFBQM2RyczV3dVR2RWdV?=
 =?utf-8?B?RG01Uml4WDRld1VlUEVRMVhIOVRXMGdRTlRLQTYzOXEvd240ZDUrRE9ZWE8x?=
 =?utf-8?B?b3RUOUVKZmxSUVF6TVhIcmdsMHRCWENOVTBjbjljK01Xb0s2ZkpMRGRTREwv?=
 =?utf-8?B?ZnhLUCs5cElyU01kaHpuZHlqa1pWTmdLWVExVFlxMzc0cUxhdkZYSmlNaHhZ?=
 =?utf-8?B?a3ZPUnNoU0tjc29senE2ZURkZmFISWErV2ZnMVI1SlR1WVF1MG10YUEzNnBS?=
 =?utf-8?B?UW1RNzc0QVAzc3Z2eHZmdTJCMTFVM25pQ1R0eldIbktsYzM2VVZvU0pyVjBH?=
 =?utf-8?B?OCtKRnVYVE9YbmF6YVRicy85N092aTh5R2VZa3VuZ2cvQVVNNEpkaHYvZ3dE?=
 =?utf-8?B?U2pyalUzUTJ0dEo2d2MvS25TblBaYXFQc0RZZUdYdTdiRndvazVna1JIU0I2?=
 =?utf-8?B?OXdOQU8xMS9Ta1R2aHJHaGZmdWl2QlJKTzVpa3RsMkUzdDJjUXIwekI1YjQ5?=
 =?utf-8?B?M29YNjh3dEhYNGVGNGg0Unlnc1Nld1FGTmFqc1RuWmFJU3krV0EyVm1YUXFN?=
 =?utf-8?B?cURjTjErYVVVQVZOT2k3UTZIR1M1SnNhRjAyTithOVYwRzFrQzM5cUFHVWxi?=
 =?utf-8?B?Y2t4a1VEdFg1ZStyK2huS3ROT0tXd2UwendYM2VEbWFkbDZBeWJWcVpGaUxU?=
 =?utf-8?Q?IuP+6L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFWei9DT3JvUzJaL1QzQjlmUWFUcHRSc3pQZm45YWVBd1JaYkNmeVc3UDhY?=
 =?utf-8?B?cVJUaFErWjNUS3JTOE5jLzdOOTBNWHdNL2JIcHBhdjNXbU1DbjVhVGpicEx4?=
 =?utf-8?B?a3FsL0RjL1dQVVYvODRPczFRQUxSZENNUkpXaEdpM0pZZVhjNkkxeVJkZ0tN?=
 =?utf-8?B?cHpqMGNkL0VBYlVtOE1xTTVTRWJOZDNBZklHbkd3MStJYkJPR0pLSEYyUWlY?=
 =?utf-8?B?TnNyNzE5UkhSWmZ3RFlUQWJQWTJMTzN1Y1NHclhzYkdwbUdUb2NYZklYWlMw?=
 =?utf-8?B?ajdRTm5INU5jM2tueTBvMmExcUlXSEY2UHRPcTBMUFNWSnRLVUhjakFSSTRn?=
 =?utf-8?B?cnNjN0R4bHF1MVdMb2YxbGpRdHdNQnJqWTNtTDFiVXBLSXFyenBJS0plYlo3?=
 =?utf-8?B?cHNSUUNVdjE3aWNyU2VMTnJzN0Z3SHNSbHJQeFdsWlVodVVpSWRhOHpVenMv?=
 =?utf-8?B?bEMwd2trKzJoNm1TNWQ0cmRDRDVBaVp5bmR5cjlhbitNWDVIdlJDK2ovcS83?=
 =?utf-8?B?enNYMkd4THNEbWl5RjVaOG9VWVNHV1BaTzBYbTVrSTFEUkRXV0taWDkrbkRt?=
 =?utf-8?B?MEozQ0YyZjJzdVlQWFVIalJxY29zd0JEeUxFaGlkZk9CNVU4Nm5XRENWRnBt?=
 =?utf-8?B?N1ZweEtBRDB2T1JQcFVmb3FhNTJXcFluVzIyTnVQUGoya2RsUVBvNHd2SnU0?=
 =?utf-8?B?MjJBTzdvU2NzenlPcndTenc4U3ZOQjUwd25EaTl1VXMvUWhFb1I0dTBVMFZQ?=
 =?utf-8?B?Ynd2SUFaaytlWHIrSHYxUm5Hckhra3pKNkdBc0QzRCtHUk8xYjF4YUN1UTdG?=
 =?utf-8?B?Uy9mR0RtazBnUnBMbzVPWXNseWRtcTlOYmNsZUhJcitoQ0xOWmZJWTd2eUdD?=
 =?utf-8?B?SkwwKzBVZEFnWlNCQjJzUW9WdEVuaDE5SDcwRUUzMkhTZE1Rb1VjVmpUNmJv?=
 =?utf-8?B?WlVFRG16SlMxVzcvbmlXVmVMWGdERzBac3dVaWl3OE5jTFJIdVNaWTVZNjBK?=
 =?utf-8?B?aG5GaFlQVk1relYyYTV2Nlp0L01xMTdIeGdvVldQd2NGc1BBTVAvdUlGY2g5?=
 =?utf-8?B?S2llSWJKWnZIQ1RPaWErRUF6S2NlNUVSMEhqMjgwbi9YS2dOdDg2K2ZzZlBV?=
 =?utf-8?B?QXhMbnV5MEtqU0NuYUN6WXVwQ2d6bUNMRHBWRTdMek5McTRjeTRuWWhrcWNm?=
 =?utf-8?B?YVRaclJmN3NwZ3BJRmZiQkpycCtOcW9qcURLS3o4dmZreDdoM082QlRMd0Nr?=
 =?utf-8?B?Q3hndm9KdklvTUdGZDNSbzJuT2czeVdJT3JIWHJZdkY5ckhmc09Sa3R5djhn?=
 =?utf-8?B?U3dOa00xOFJrZ284R3hsSVM5eHBYRFB3UDEyejNVY2JkZ0lEeS9MbS9KUXJE?=
 =?utf-8?B?NXUvakh2c05YL1ppS1FYZTU5bzdUYkFMVmdscU1pSjlsZEVuaHhMNWFqSTZ3?=
 =?utf-8?B?SWN6Z2J5Y2I2a3h0TXBIY240ZS9FcVEweVAwWHJ4ZWVHOUJ2NFAyT1JLbmZw?=
 =?utf-8?B?UHpvQ00rSjZzUGVKYjZhYzBGcE1lT1ZBOEN4RjJoTDdJanplT0lGN2pyM0xF?=
 =?utf-8?B?WTF2cjZhOXhjT3JXZEJNWWdBSERVRDhUSUg3eVhkVzFjQm1Pb2ZOZDhxbG9q?=
 =?utf-8?B?WTBSWmpzVkkwVUxtMUdKbURCSHNOS3B5OVhtMy9JTFoydGdINTNJKzRwYkZF?=
 =?utf-8?B?VVgzTHY0cEFHenFtM2pkL3MvMWlWeVQzMWU4d3ZvY0xqbjNVaE14ZFhLZHdO?=
 =?utf-8?B?TjBLd0ZaRVk4NjV4VWR0UXlCMzhhMDl1R2RRZ0I5UC9jTlRuOXlja25vamdF?=
 =?utf-8?B?K0VqT2VQc1dFK3JuZ2VaM2Y2LzdlZ0dXWDlnZWtBZlpNdklweGtLSTlwRi9U?=
 =?utf-8?B?WTlTM2RKRjhTVkRBbzRRQU0vdU5KYzV4NWJsdXptRXlWbTNEeDE1RUg3dmZZ?=
 =?utf-8?B?NE15ekJ1dlRXVUxSMWRqakdIRDF0YmZ3WkJhQmplY3hsenBpakJKQXIxVUd6?=
 =?utf-8?B?MHlGdUhORjJZb0RHa1J2bkY0TEhMSVdqNElEeERmTThkNytldlJwVUExNnJL?=
 =?utf-8?B?WTBIMmpQdUt4b2wxcklWRFVFY3lRMlpzM0ZNTVFPc0FnTkNMQVpmMDRFWStR?=
 =?utf-8?B?U3EyYjFkMWxkanU3Z3FWdEh1QXFmeHc2RHlkMVFjVWVxTGNiY01HRmdBaitV?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cc5bb4-1e5a-44e1-51c3-08de31fd2f7d
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 23:47:42.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r456RhIxOEqfTJBhSjQVmZQ0OYw1kTfw1CAw2WtBWFUWuevD65BqN9ZhpMyq5bFUOO+g9N0weaHB51k1bALctIEwgzz7xnfL5WCbssddqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5689

This patch series adds dma-coherent property for the Agilex5 platform by:

- Updating the device tree bindings for:
  - Cadence HP NAND controller (`cdns,hp-nfc`)
  - Synopsys DesignWare AXI DMA controller (`snps,dw-axi-dmac`)
  to accept the `dma-coherent` property.

- Adding the dma-coherent property to the Agilex5 device tree and wiring up
  the property to the supported peripherals:
  - NAND controller
  - DMA controller

This dma-coherent addition aligns the Agilex5 platform with ARM’s
architectural requirements for coherent interconnects.

---
Notes:
This patch series is applied and validated on socfpga dts maintainer's
branch
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

This changes is validated on:
	- intel/socfpga_agilex5_socdk.dtb
	- snps,dw-axi-dmac.yaml
	- snps,dw-axi-dmac.yaml intel/socfpga_agilex5_socdk.dtb 
	- cdns,hp-nfc.yaml 
	- cdns,hp-nfc.yaml intel/socfpga_agilex5_socdk.dtb

Changes in v2:
	- Rephrase git commit message to describe why the property is
	  needed now.
	- Remove redundant statement in the git commit message.
	- Correct the version in patch series title to v2. 
---
Khairul Anuar Romli (3):
  dt-bindings: mtd: cdns,hp-nfc: Add dma-coherent property
  dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent property
  arm64: dts: socfpga: agilex5: Add dma-coherent property

 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml      | 2 ++
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi              | 3 +++
 3 files changed, 7 insertions(+)

-- 
2.43.7


