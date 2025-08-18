Return-Path: <dmaengine+bounces-6052-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D64B29C72
	for <lists+dmaengine@lfdr.de>; Mon, 18 Aug 2025 10:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5745E3B91DF
	for <lists+dmaengine@lfdr.de>; Mon, 18 Aug 2025 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBAB3002DA;
	Mon, 18 Aug 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="wpeUs8A4"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA725D549;
	Mon, 18 Aug 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506487; cv=fail; b=dHIjp+3FixBeMKXO19O+UZ7mLDz2GhLTJpCNZ7/NpxfPD377xcwMOfgSVeBA5NowxVjHmYp3YXyuV3ptV7S1yVvYDVdyjIjH7NlfbreGzqizWC69jX+VFsrOyPbPrJ5RkzmdUaghlFTG8fi9nLOOY0uOuGVeVcoHYua35se2i4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506487; c=relaxed/simple;
	bh=dLA2yuOdZr2/8C2tR7uHQGGNBdPZvw2a7xzhK0XZkog=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cHFiGzKGEz/sao+yZ9HFuZMq9+qwrTGHw24MN8emdxsmAG08/OBOnSIWMtSQD8UCd4L7FrQEA2WtictFrVzQu7y5XWB+TpzmR6MzQmEHNIIU9j44MTfOpPcXczFUet9gojXvXtH0hUGgIVk0rN0jjUugHR/NeLr1NZoQz7jmaWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=wpeUs8A4; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoONfniIHFDkefQJ/cqFmQpf0WJ6P42cfcVhzzgv7NSfQicmScGVJ0xOIHagvkQqwmT4B5QegA5fwJ2N6loA8yHDkWimqyK7Z4CyL4yXM3jSo0P+8YCNosKegR0CwpJ5AnIS/bFJzrV6oiTeB97H2gwdoIUc2ij1ZkHbhEyG/QS1aS5kbz7r0I8UKQTpTHgpItOzbJEIbefApiF85sCqh7xLNORRcsBgytjdCROqH0mzs8nOT9lT+Eco01shljvR6zG95vsAEcnDcy76REXpYC/5JTCY1Fc0N3nZDHkxUjqS+KfqDt8mtW3230jeBwYihGCOrXirdL0itfC3JIY7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLA2yuOdZr2/8C2tR7uHQGGNBdPZvw2a7xzhK0XZkog=;
 b=MWDQJWCsDKmy3pasgZWH6tryLmjH9y7Cnx57HysiKKdZzSuNnHTovIIMr8U38FTo6JNQ2Gk263KRCKouoN/sRf5pk4hvJpQE+yPjqj/+uX6g8DMDGL1dHqtYHYLT2ow4zmB+83x62xJ4yuSwq92n8oF7M9R2J9nvvFUt6Q3x61jFT/+E+UuFHQmJBAs20l0pFLqXtbP3rlDKWWURs3dA4sv7Kk398EnUhyh3F4I1/VINXATYfVK01h/s46ZL3LhjTTNLbgyjiePrRGfhNhC5SFaR2XzCySDw2Ab3iCUAQ9qjIY+k/9ASajy4JAAetlx8U2HweElTr1C6PYAtjR2x/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLA2yuOdZr2/8C2tR7uHQGGNBdPZvw2a7xzhK0XZkog=;
 b=wpeUs8A4VnCpV2BPSCIHBqhPMiA69rdH+1zM3c6mU90tVgP+PQiaI1UEmvkLlCSvuRz/mISCNA2qo4z4CjMyMEfjbrGMqim/a9bO0Sp5DI03rq/O2vwdRbdxws+qtzGidF16Pm3qis+29ja9Ym5+XaCAI1Euk60F0nTepJi2onT5Bmm7sI78jSjmae1WahYvpOgJ09IuA+YhsNoWnZ5zARQ54s7glCNdHpsIuBzW0IRFJDIZFPMdBeBLXjeaChzpR8xELoAGH+oFT3P/Bg3KIMMmFeJ5oduQMef3utT5ORsKsXJ7P7I7JO6Yu48WA3AMhoH3pyD6NClbMNmaFVdIzw==
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by MW4PR19MB6933.namprd19.prod.outlook.com (2603:10b6:303:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 08:41:22 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:41:21 +0000
From: Yi xin Zhu <yzhu@maxlinear.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "kees@kernel.org"
	<kees@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"av2082000@gmail.com" <av2082000@gmail.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: lgm-dma: Added intel,dma-sw-desc
 property.
Thread-Topic: [PATCH v2 1/3] dt-bindings: lgm-dma: Added intel,dma-sw-desc
 property.
Thread-Index:
 AQHcCBPALrBJpgW7V0mdzTs1Qi24hLRYReGAgAsMz+CAABtMgIAADGZAgAAXYQCABH7ZMA==
Date: Mon, 18 Aug 2025 08:41:21 +0000
Message-ID:
 <SA1PR19MB490914561C8ADF3012814D69C231A@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <20250808032243.3796335-1-yzhu@maxlinear.com>
 <32a2ec88-b9b8-4c4d-9836-838702e4e136@kernel.org>
 <SA1PR19MB490961745C428F56D7E114F7C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
 <a0a1bc99-0322-4f63-a903-12983facddc9@kernel.org>
 <SA1PR19MB4909BA87E8CE98B5A6389349C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
 <1826bd7a-621d-49d0-b6ff-7ff723ec9f2c@kernel.org>
In-Reply-To: <1826bd7a-621d-49d0-b6ff-7ff723ec9f2c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|MW4PR19MB6933:EE_
x-ms-office365-filtering-correlation-id: 00932871-c3f4-4084-5498-08ddde330226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWtNNS9TODdyR1duazJCNFJOcWdaemp4WUZheFlENW9xN0ZKVzNnQjlZMlky?=
 =?utf-8?B?NU8xV0FieU1pNE5McmVvSmpCY2RMbmc2cUZWeGNmbHdNVEh5UEJMZFkyYjRa?=
 =?utf-8?B?VlMzcG9LeFBuMkthK1Z1S0sxdkJWeUxSSUFkWFZ2NUhxMU1rQ0IrVjlTaVNH?=
 =?utf-8?B?S1VuL2pMZUVZa3dNa05mWFJxTVhDcWUxd09oWEszcW1lOWgrREhCNWVRM2ZD?=
 =?utf-8?B?anU5bmgxOEtVWVZRK3pxQjFodzd0aWJRYlNYK1RYSjRRR1Vqc044WlNsSlkx?=
 =?utf-8?B?cHBGSmlPTzlTV2N2ck5Lbkw1d2RxL09KZ3l3WlByRGJyenBJbStua2h4Z3pI?=
 =?utf-8?B?Vy80TlpLVFFNUFpVMU54cHVXSy9TdGllMHF2dkVJOHhHN3lMTU1Cc0lQT2dl?=
 =?utf-8?B?RkVaUTFEaFg1WnRiVkIveXJ0SnpVWDhFN0pnUkJMdjNhcE5mNzI1ZUx1WW9k?=
 =?utf-8?B?QWxaZWlSblZQMGFodlF1dCsxS0gvRGZ6ZENjdHduUkpsRGJIdkxKajBOVlJN?=
 =?utf-8?B?TmtLSFlxSDBreEpYZ0xZK0JCRXZWNUNJaTdQTmlWclgvakhjZXlkVE9kQmxo?=
 =?utf-8?B?YU01L0xiVFFndzgyWjZScmdKUCtFS3kxeVcvYVFiZ0lGVG9KR2U3bmNVNkp4?=
 =?utf-8?B?T3ZmMEZKc0tZS0hFODJNLzlnbjk5YURXUXIwSklKZlpWYSs2NGFDZlBDSE5L?=
 =?utf-8?B?ZTk0b01jZE1IdE40MWxxU3hZeUZIWHhTSTExRGIwd0hKOFlCS1pMNCtJb2Jl?=
 =?utf-8?B?Z2xWYmV0NXpsV2E1VTFSeGduQVFLRzFKYlkzWWZocFdZcm9OTTNRQjhDRWNp?=
 =?utf-8?B?bXRqRVhtdEhIUWJ4VXkvdURyLzd4YklCZW9DTG9MVUxKNWswR0V5ak1NMUVL?=
 =?utf-8?B?SXBXSzRlSFh3U29JOFpsdVdKQWplWnNaRittbERUS1BzZlhHVkFweXBtK09o?=
 =?utf-8?B?aHRNQk5RL0xzdHMxaG11N0w5TERtSkllK2RIZ053bExRVURlMWs2TkN1eHRL?=
 =?utf-8?B?Rkc5TGRKRXdpaE5aWHhrV0hxOVljZThUMEhsVUZndnp4V011VFpOeGd1akZD?=
 =?utf-8?B?dUxVdmQ2VGdrZjBDNUJkYVZaMDVHV1YyZVpzMEZ1cWRsMGxHZG9Pb0ZsRjdF?=
 =?utf-8?B?WVVUSFJHc1lVNVVvR3FzMFBFOGRYcnIzMzdjZDNGVU1WMWxUSDMwNm0yK2Nv?=
 =?utf-8?B?RklHb2VmaFpkc2lBUkpWdUZUV2E2ZVl1RjFGdzQ0Q0ZJUk9ibHNyK2p4Ny9K?=
 =?utf-8?B?dUhPczhhSjdkajRoOFNzUHZXUC9xNmRJTkswQzJKbzJ0YkF1VDhwNTRMU0s1?=
 =?utf-8?B?Y0dFSU1iN2J5b2NGeERKQVlQaldsakY5aHRsZHZTd2I4cjQ4N09IY2w1ODJn?=
 =?utf-8?B?SE1GQzZHNWV0L2V6RCs3VFhad0R2ZU1VaHFuWFRVMjdQTjc1cTl4RHBJN0hj?=
 =?utf-8?B?VnEyamsvYjRFQURQQkJWSzVGa0oxWDJQMlhPckVSTGFVNURsWW5lc2JFcmR1?=
 =?utf-8?B?WmFaSlV5WERKT0JkK09mWjl6ZmdSWnRoWWpTVDBUalJvUWtvelNRUm44ZDZH?=
 =?utf-8?B?SDNZK0tjZ0daNWt3S21NZjFudlpmZ0JKSUhXS2RwQjVlbnQrd2FEZnh3NHJL?=
 =?utf-8?B?dXN2RGVZT3NCSU5nOWxWZmp0aFR6aHZuZ3Q2Q21ENnI5dGdxdlk0RHBLRlV4?=
 =?utf-8?B?a0xUT3dlSmZpNnVJbEtESHJqZDFXT1RQdXUrYW5HRktDU1g2WExZdm43UDh1?=
 =?utf-8?B?Ymlxa1BtbW9Zb0h2dFZscllzVXRRSVBHVHc1SnVHNHBzYVdzWEtYRk5FYXVj?=
 =?utf-8?B?aVNNUkpjQ2N2NVFvMmpqNHRVWG9hMFU1dzNkeTBPSGQzK1lJYmRqMVhUS0RG?=
 =?utf-8?B?NHRvREdIaDFKNzIzZ0JwZ25xNGR3N0JQck94cU5HSTdPalVyd3pvRzd5bjc4?=
 =?utf-8?B?azJYQVdWclc2Y0tpOHBHVzhtSjh4SExkRmZNamRPaGVoMDlySU9WUDNiRTV6?=
 =?utf-8?Q?lXULrNVlXFPLHaPyibGkJsOAt0hIlg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3V4emovMGk2WEdmcEZGUTh2RVhtbWlFVWcwL1ZzZW9aQ0dkWmlBVVBIRGZ3?=
 =?utf-8?B?SjN0T3F1SWoyRUpGckhZSDhubUtibkdIVjhrRVdlcXdiU1QwRGJValFPeGxz?=
 =?utf-8?B?c3NSYndrY3NhNm90dFIzbTVSYVJBdDRuME54R0FsazNuc2h2WEdSY2FrOHcv?=
 =?utf-8?B?VmJ0TklyWkJGNWFUQTZmMENsUmJza0piZk9LeElKZncwMytMUHltZ0Fyd0hI?=
 =?utf-8?B?RnlYK29BZVVkMkR5Y0xMWUhDOGlFdFJTQThuRDUwalM3NnVDREcwNmY1NmJs?=
 =?utf-8?B?S0taSUlHMTJzaTYvOFdpOG95K1pwbzJ1N1laNGxhd2tzQkN6Yk43U28rWmpY?=
 =?utf-8?B?RjlHQm1VT1B3SUtRZHM0ZHhBeHYxQmgxYWlXbjlaalh6VTJxVHlQVmEwOXEy?=
 =?utf-8?B?RStEemcxVHhMcUp4dlRVeXlRVldVcGcrUmU2QjUwN0ozREtoYVJ2T2xRWHow?=
 =?utf-8?B?SmF6eGpqb0tSY1VFMXJ5YUpheEN5UnJoMHdSVGttV2pBcTRqZCtLWmFCYVE4?=
 =?utf-8?B?Z2E5cWg1bFBMVWpuUWpVUk10b2lwOVdqYnJKWjJHdDJtSTZiODRlMXpZNml1?=
 =?utf-8?B?MXJWSTN1aEFDdkR3QlVCeUdIa0FEK0FSaUxiNHpTYURSTlNGRlo1eDRLcmQz?=
 =?utf-8?B?L3E2N2FHWlFnakNMeGx1UW1QREFKZUkrZmpnWWdZYkcvNENLTEZHbTExVTZP?=
 =?utf-8?B?RnFTcTBscFlBNW1XUzJCL05UTEdIYTNob2pXUEdMN1JoS211SVdhL0dvc2wx?=
 =?utf-8?B?UDYxZklXKzlabzNieWF3emZ1L0ozYkVTTjdySzNnYkp4KzVQNjhsM3NMU3pp?=
 =?utf-8?B?d21USUZuNFo2RG9LT0taK09zU2N5MkhsUC9zU0ZzbHY3eldiWUJ3dmxwZmNQ?=
 =?utf-8?B?SlQrY01EUTZkVlpHNjJnWWRqWkw5WHg0d2krbW85ZGZnemhtSUlWQUUzOWRl?=
 =?utf-8?B?c2k5dVVRQTFoVUd0ZnIrMTlZalBrUVNFaGpWUGxGWTA1MndJbFRUbk5Ddlh2?=
 =?utf-8?B?RzhmUk5OTnRlZWpsREQrR1JUYlhXOUEwakUrNmp3NHhCUCtxekVhZVJSUFhY?=
 =?utf-8?B?L0lQc1V3S256cnlpaVZVL0R3aFp5b1N1bXpvdDdrSEhQajBUR2xrVmpIU1cr?=
 =?utf-8?B?MjMvckp6MEd6R1RzUjZ4bVV0aEJKUE4zYlE5QTF6ditLTVlid0QwNUxZNzlr?=
 =?utf-8?B?RVpNSEVQSkJZQ2JtVE1oZldoUDVWTSsreHRtdzFNUFpTWVF4SmlWQmx6VkVo?=
 =?utf-8?B?cWhvRjZVc0hTaDNFdnZ2QVBML2gxUHRyNVRiQjl5VWd6VzJ1Wm8yWTFpYmlZ?=
 =?utf-8?B?S0hoTEVla2l2akVBUHZ6aEFkNkM3S0syZTV4cUU1amZJcTFXOHhhTmZianht?=
 =?utf-8?B?QytqYnBVNWVVQ1l5dmRiU3hOT2JXUGxPVXAvWlNUSXdUb2RSSENJbWJIa3Nw?=
 =?utf-8?B?MnRVT1pyaXVyM3hWSWNnWTM0cERQcUFBbFVWNWJhV0lWQ0lhSWNkRUdvb3NH?=
 =?utf-8?B?Q3lvTjk0Z3U0VU5NSXlaNE9ERFBNSXJaZ0VVbG56aE8rWTZXTEc3U2o4NkxE?=
 =?utf-8?B?MC9xNkhWdG5wRFFTamM4eFlyM1A0eUR3Q29nU1VBK1R0cytNQTEwcVV4bmQ3?=
 =?utf-8?B?OFdlWjVWVzhOUm5jQS83anVqOHdiSm8wbktCeVNrVVMrTkVZQW85TnRsWUFL?=
 =?utf-8?B?YjZkS2FPTldWdVJFaEdJQlNiWFIzamFtbHBkRS9pYnpiTEhFQjY0aDBjazAy?=
 =?utf-8?B?U25pSVYzaXBXTFlhdnJCTkp0WFMrUzRTbUZjZXR2ay9sbmhsUWwxVXg1a3dB?=
 =?utf-8?B?QVhoN0tOSXBBakYrSTBueitsT2N5cHhrUEdxS2FOOEJaTXZDTHpPbjBWV0lj?=
 =?utf-8?B?cllOT3d1bU4zUHAwWnV5S1VVSExTZjl6dG9pR0FJYTBock80c3FGbmtlRHl1?=
 =?utf-8?B?TmVtcjlENE1MV2JYN2dqdFJFRW5kSEh3SDkrM3h6NVY1RmVSR3ZCalFodXRk?=
 =?utf-8?B?Y1RYTWQzMzd1UXIyWkNvczRtYk9vOHF2em5wRTlTbUdQL29xRzQ5ck03aDlJ?=
 =?utf-8?B?SzhoVVB3cUFRS051bDFwSkpvaEN1L1dVVnJWclE0eTV2cE5ybDJZbklnNW1J?=
 =?utf-8?Q?s5IDgklC2frEokX/xUA4Uwdk3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4909.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00932871-c3f4-4084-5498-08ddde330226
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 08:41:21.6965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVGrfGPLzHOZMXnhYakI2yFyWiHdkSRueC+9VQgKbM2sAdsI8e0TK/yXFm8TVGZvVJFFr8lTAnqS6V6wR+Bd/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6933

SGkgS3J6eXN6dG9mLA0KDQpPbiAxNS8wOC8yMDI1IDE4OjQwLCBLcnp5c3p0b2Ygd3JvdGU6DQo+
IA0KPiANCj4gV2hhdCBpcyBhICJTb0MgbGV2ZWwgY29uZmlndXJhdGlvbiI/DQo+IA0KPiBGcm9t
IHlvdXIgZXhwbGFuYXRpb24gMSsyIGl0IGZlZWxzIGxpa2UgY29uc3VtZXIgY2hvb3NlcyBpdC4g
V2hlcmUgaXMgYSBmdWxsIERUUw0KPiBzaG93aW5nIGFsbCB0aGlzPw0KPiANCj4gDQo+ID4gb2Yg
dGhlIERNQSBpbnN0YW5jZXMgd29yayBpbiBoYXJkd2FyZSBkZXNjcmlwdG9yIG1vZGUgd2hpbGUg
b3RoZXIgRE1BDQo+ID4gaW5zdGFuY2VzIHdvcmsgaW4gc29mdHdhcmUgZGVzY3JpcHRvciBtb2Rl
IG9yIGFsbCBpbiBIVy9TVyBtb2RlLg0KPiA+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQpJbiB0aGUgTEdNIFNvQywgIFRoZSBETUEgaW5zdGFuY2VzIGFyZSBkZWZhdWx0IGNv
bm5lY3RlZCB0byBDQk0oY2VudHJhbCBidWZmZXIgbWFuYWdlcikgdG8gYXV0b21hdGUgdGhlIERN
QSBkZXNjcmlwdG9ycy4gIA0KSXQgY2FuIGFsc28gYmUgZGV0YWNoZWQgZnJvbSBDQk0gdG8gdXNl
IGl0IGluIGRpZmZlcmVudCB1c2UgY2FzZXMgaW5kaXZpZHVhbGx5Lg0KDQpJbiB0aGUgSFcgZGVz
Y3JpcHRvciBjYXNlLCAgdGhlIGRldmljZSB0cmVlIHdvdWxkIGJlIGxpa2U6DQoNCmRtYTF0eDog
ZG1hLWNvbnRyb2xsZXJAZTczMDAwMDAgew0KICAgICAgY29tcGF0aWJsZSA9ICJpbnRlbCxsZ20t
ZG1hMXR4IjsNCiAgICAgIHJlZyA9IDwweGU3MzAwMDAwIDB4MTAwMD47DQogICAgICAuLi4NCiAg
ICAgICNkbWEtY2VsbHMgPSA8Mz47DQogICAgICBpbnRlbCxkbWEtcG9sbC1jbnQgPSA8MTY+Ow0K
fTsNCg0KY2JtOiBjYm1AZTEwMDAwMDAgew0KICAgZG1hcyA9IDwmZG1hMXR4IDAgMCA2ND4sIDwm
ZG1hMXR4IDEgMCA2ND4gLi4uIDwmZG1hMXR4IDE1IDAgNjQ+Ow0KICAgDQp9Ow0KDQpETUEgSFcg
ZmVhdHVyZSwgZGVzY19mb2QoZGVzY3JpcHRvciBmZXRjaCBvbiBkZW1hbmQpIGFuZCBkZXNjX2lu
X3NyYW0gYXJlIHR1cm5lZCBvbiBpbiB0aGUgRE1BIGNvbnRyb2xsZXIgaW4gdGhpcyBjYXNlLg0K
VGhlc2UgSFcgZmVhdHVyZXMgYXJlIGRlZmluZWQgaW4gcGxhdGZvcm0gZGF0YSBpbiB0aGUgZXhp
c3RpbmcgRE1BIGRyaXZlciBhcyBkZWZhdWx0IGVuYWJsZWQuDQpzdGF0aWMgY29uc3Qgc3RydWN0
IGxkbWFfaW5zdF9kYXRhIGRtYTF0eCA9IHsNCgkuLi4NCgkuZGVzY19mb2QgPSB0cnVlOw0KCS5k
ZXNjX2luX3NyYW0gPSB0cnVlOw0KfTsNCg0KSW4gdGhlIFNXIGRlc2NyaXB0b3IgbWFuYWdlbWVu
dCBjYXNlLCAgdGhlIGRldmljZSB0cmVlIHdvdWxkIGJlIGxpa2U6DQoNCmRtYTF0eDogZG1hLWNv
bnRyb2xsZXJAZTczMDAwMDAgew0KICAgICAgY29tcGF0aWJsZSA9ICJpbnRlbCxsZ20tZG1hMXR4
IjsNCiAgICAgIHJlZyA9IDwweGU3MzAwMDAwIDB4MTAwMD47DQogICAgICAuLi4NCiAgICAgICNk
bWEtY2VsbHMgPSA8Mz47DQogICAgICBpbnRlbCxkbWEtcG9sbC1jbnQgPSA8MTY+Ow0KICAgICAg
aW50ZWwsZG1hLXN3LWRlc2M7DQp9Ow0KDQpldGg6IGV0aEBhMDAwMDAgew0KICAgZG1hcyA9IDwm
ZG1hMXR4IDAgMCA2ND47DQp9Ow0KRXRoZXJuZXQgZHJpdmVyIGlzIGFuIGV4YW1wbGUgdG8gdXNl
IHRoZSBETUEgdG8gdHJhbnNmZXIgZGF0YS4gIA0KSW4gdGhlIFNXIGRlc2NyaXB0b3IgbWFuYWdl
bWVudCBjYXNlLCAgRE1BIGRyaXZlciBtdXN0IHR1cm4gb2ZmDQpETUEgSFcgZmVhdHVyZSBkZXNj
X2ZvZCBhbmQgZGVzY19pbl9zcmFtIHRvIGdpdmUgdGhlIGNvbnRyb2wgdG8gQ1BVLg0KDQpCZXN0
IHJlZ2FyZHMsDQpZaXhpbg0KDQo=

