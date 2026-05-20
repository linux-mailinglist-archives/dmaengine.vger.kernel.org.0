Return-Path: <dmaengine+bounces-10567-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDNID0wjDWrctgUAu9opvQ
	(envelope-from <dmaengine+bounces-10567-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 04:58:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36C58700B
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 04:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51D9A3009F06
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 02:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED3830EF92;
	Wed, 20 May 2026 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="j6uOScl6"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45128248861
	for <dmaengine@vger.kernel.org>; Wed, 20 May 2026 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245895; cv=fail; b=h+piseF/vVft3/qHgYyJl4fhKc7At4CXWkIXET63XGMa/KhTVNsMRqRBc6GlyLYl1efBAjj20VFWpJ9ZbDqRm4TIW+ZaR++BbhDbYCrffJlr75botqHai/cwEt74j4CBTt3HXqrqqC/kUBQBCfK70C1omiWpWMJMgK8EbtAh2nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245895; c=relaxed/simple;
	bh=Y5JTOfDSCAWTAEktGEjoVaKtyW0J0cc1owRAR8ziK/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sCnL9r10J6+wFxKD4CpstCQFlBZTFPItmCP6QEX9EbQPAiHtx8Yj/ggh3cVXfX94gBTemklVOJTL5ct1wFUzirZ7evTuoDQ/CHnYy4+fnD4nWsCtkvhQ37usySKKVCIpvtlQ+dK9WKj12byNIx9jwBb69heP66gJf5YV6S3pG8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=j6uOScl6; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKvL2QLacf0cxRDmg2CFxcoCUynkUu3efSgvBaJeC3xa/vimE/WNSQrl1uvy5lkNWPAHIlXPqwCsfQLWZcq+qqvPhSF+DpF0WcJh1OtFEYWl6r/OziY9H7h3bOjw7eCGe5kuiR2LhNl6ghej/+wNdLSEyFOdbRgHaAUUR10KW5LKFP+uVVWUhjcRTaXdBHjM2phEroUYy0nPXhFzYCYh/Bfarfue0iJmUW9rlw+YEimUi1rgNDlgy0AEnarQL6UWfGWuMdr/3uGR10ReqA5DQwc67QNSi0zQeKx38CS9kJjOIhGADlgjCHvwhqsyGpOWoBjU/kuzMNp0Uka1StJ2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5JTOfDSCAWTAEktGEjoVaKtyW0J0cc1owRAR8ziK/8=;
 b=FNEdHdpCzIiv4cMrX29fTAFSLavxQAEf1cjfMCAsAr9NOqCWjdh/BdAH/D/f60fkoKswC1sgGhDnsIsW+qOQ5P2itGFwSf4XLX9HIQrkyLJMYSPaHBpCGf7MQ9sHKxoqvOCnRqJKyFjYLfBkElMO4YpOWn8CAnj1iK7h/XwU+wJTDMUbHmfSKyR28qJ5NDtEciE+r08QKfWBnzjnqzfAwnNDQKvjfDojZwVHpoV8YM+8hCgxY1t7nGydTuVEFW4jepy+JHztYuUatTvKJGzEN8FGW+gVFV5kTbxkTMwb1Ssl9mE8xp/AEg5l9GxymFbTN4eg7ARXhFdPbm4YJ2urXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5JTOfDSCAWTAEktGEjoVaKtyW0J0cc1owRAR8ziK/8=;
 b=j6uOScl6mc3EIKD3mWifMpmebcdtWR30iPFGCy2pCtd9aZ5KTpvmDPd0E8InORYCb0h726BoTODhlZWt5n1XASRAYwzxVN2J2PR/m9/CU+f4FPyh+8gMhAvvWauU8iE5rHmV5h4OeWLN6ikMGUUPMQtgyaX6UJYcpHbTUZCVQnCtMRN2Qvk7j5t7SsI9vYRHwCWwoQboNJg52Ue829yuOdr3tam79/r/8w8D09C1kAIGpdAIpNQtCFIILAAqOEhZxfYrKMoSZRdasbLEtztR46JKqkaFBLlNFRpdA2udkpdUyyyr51sJ5G+uKpGlvhVnJxiYch4qrbo7B/sbu4I0oA==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DS0PR03MB8318.namprd03.prod.outlook.com (2603:10b6:8:28c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 02:58:10 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 02:58:10 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
Subject: Re: [PATCH] dma: altera-msgdma: Replace memcpy with io32write in
 msgdma_copy_one
Thread-Topic: [PATCH] dma: altera-msgdma: Replace memcpy with io32write in
 msgdma_copy_one
Thread-Index: AQHc51tYFSPJSHId1UCxmI2LBqJobbYU8JqAgAFJqYA=
Date: Wed, 20 May 2026 02:58:10 +0000
Message-ID: <b3f1ad76-9575-4dde-815e-636eb8ba1c91@altera.com>
References:
 <4586c39b43aa3b9480989940fe905dac40c8cefc.1779173156.git.tze.yee.ng@altera.com>
 <20260519071815.EC443C2BCC6@smtp.kernel.org>
In-Reply-To: <20260519071815.EC443C2BCC6@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|DS0PR03MB8318:EE_
x-ms-office365-filtering-correlation-id: d63ca9de-7c3d-44d8-6313-08deb61ba084
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021|55112099003|11063799006|3023799007|4133799003|4143699003;
x-microsoft-antispam-message-info:
 Edslp2pS8l+L0RVEPqxWamTUOSRJNaWrop8U0SoNf7n/6DbYR+Gu5pBicphdcs9thKnTNrAABwC+DeD8EKHyNPe8WIeVSRGJmZtkvZS0jEdQXtwxAcSOHz6XecCsyYRvGrAO1vqbsGJpagAhMBWmq4AbgdJiniZDPSqvBRzGGa4GVPlNfJuc+qWi5c62kbvS8w+wMSV16H3RSLWa8FIIPEd3AHd83AQAMfaPgLOTsIkO6CkrBvUx82fynoFmstfEa3S/QyjSUqmVPEjAjcJUCiK5whuLES+XtsD9tmDoXgTOqNVKgpLh3PsQ4tEa74RemQDkq07f5QVlfqZ+QiY3K1VEI3GMPNlzA7nXCspy3aJxGdWpyUfOupKfphsiA6EhfRGXrQXCzN3Ym/CSNg2M6uZ0MTbAdkNZorW0HFHn12IRRYd0wsa59KUtbjKky4RieRt4dQbLWa1HZCqVYWSwfc2eoUDcGkgVKiq7EROKEyKYctEVn348hpxHanXk81lUc0GWJqi++HYrOo3wnM7IBa9aC3P693ksgqQZFcQKd8WB3RhSnQRQPrMwJ1oHdQKYPDHTLVfIO4ggFUSxnjwmYfSQsW5FRTMfhAAgzWRCkBDv9kkLH79dKxICMBkrqXQGEyErTmBNGMVCgtQ95juq0+xxPgnzydrUvW3kSOQr3SeFBZsufFvz78VX9H+MBSvk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021)(55112099003)(11063799006)(3023799007)(4133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmdKZ2xtOUZyN2FWVkpab3h5c3lxMGxFZDlsbUs4bmsvMk0wL2JmNVFtSmZ5?=
 =?utf-8?B?c0dzNGwzNDRqUUFYR1kvRXM0R3V6eEN5bmFYSGx5djFmSGNub1FWdldYSGJO?=
 =?utf-8?B?emlnSDU4a01ndlFuQVpHa1RJa2pnY0pRTXlTSGc2SW1GN01YZkwrUVVJSzBw?=
 =?utf-8?B?YmovQXN6UzRvWHZmRXJJejUrYTRmNEJWb05aMEhRdnFvLzI0cnpqL0ZJT1hR?=
 =?utf-8?B?eTVQeitNNXd2dVVPT3kraTlERlcxbGlhK1pYYXhta2xwSnA3dC9yWVE3aVhx?=
 =?utf-8?B?MnpJTFJkQTVKcXNYWWp1S2NsampJNGJKa1JUTVJ0UDZvMUhYUmpWdXplbEFZ?=
 =?utf-8?B?RVpOZGpMSXlhdTlRaVhaSGw2SjZGTzVoMHY1RDJpR1pnSHNiUE9DTUxYMTYr?=
 =?utf-8?B?dWtmYjgzYXAxc1hFQUpsYkhNbXRZUThqSXpQMjdscW91SUVTRDBnUGtNNzZj?=
 =?utf-8?B?VFhxVFJGNHRWcDRpN01PaDM2MGlQQUZsb1RWeHByb2dFWnE0eWZhRFlOdEVl?=
 =?utf-8?B?dVdKYnVRMzVBZjFPTnY5T1dSUW5oY2VPUCtlNUVmY09XODV4bGtFZ04xR0Rk?=
 =?utf-8?B?MWtqSDN1dzlvRWg3aWR0d29yQi9hMGZxclZJM2JmMDZJaWVlTXgvc1FOcE85?=
 =?utf-8?B?cWpwUWRLUGJuQnlleEp3dXJ6OXhKK0hwaWs5NHUxeUN3SkRCL1VTY3RlaXZH?=
 =?utf-8?B?dUhhWEUyakdDazRjeUovWkNUc1lzeUNnTEYzUE8yZDZtbjZ5MDVkOXdjMGRN?=
 =?utf-8?B?T21FZW8wc2hHeklFYjYxNVdlbDh5QVlGRjB5bzFmMllrVlZuQTQvR25YZ3RB?=
 =?utf-8?B?eU5vRFROcmhIcGlCbHJRdzRrZDBSQklFY0VQVDNyR0oxS3dQRHpuQnBjb1RI?=
 =?utf-8?B?RHRYcjRDNCtvSndjbHhaUDBtNkhOK0ZiNWorRkw2VmQxZHhVVFZ5Q3Rqa3hG?=
 =?utf-8?B?MFlBYWd6aWFSeUVuQVlteXNEV2twanJEbSt3TmZLbHVJa25mVFMvaVlsZGo0?=
 =?utf-8?B?enZNUGZ1VnlZYW9CV3E0bUh1QVcyWTdtK1dGWi9wbzZrTjl4SHN0Q1pzTGwy?=
 =?utf-8?B?U3R1My8ybURwWlhhdHV2eGY4R1A3bFJkSlRWb3dFUGppdDBCeHZCaERKa2NI?=
 =?utf-8?B?ZjE1cGlSZDhZV1FNZWdCN0kwb3lmVUZYK2hEMlBjeVZsSFRRclVkeVVwRnpm?=
 =?utf-8?B?c3Y1ajJmL3dOVEt5NXp6c1YwRGlYdFJsVUNBeFl3dzZwVEZtVTZkcnM4dkJ6?=
 =?utf-8?B?NE53WE4vNENmOThSM3Z1Q0VlZ2I2cmNVVVNpZ2x4RkdjVkROSEtCa1BvdXdl?=
 =?utf-8?B?SGhlVDZ1NGxGaTgzdTNIeGtyWXFJbVN2bHVJYisvMWxmSHI0VFdFSW9wdmhk?=
 =?utf-8?B?dzcybHJYWkkrYzdUWHE1bDlBdnhPSTVMMTJHbGJ5L25mUFl0dXhoM2JzMDU5?=
 =?utf-8?B?YldabHNHVXc3Y3RHSy9tQW5LZzgwKzVWaU9MWWM5QkhGcjI1V0pXditEY3dG?=
 =?utf-8?B?OWU4NGNFSTM4Q2owV2RENllQWDhnaUxJdlYxTGZ2dTdsUFpIL2U3VC9JdVpo?=
 =?utf-8?B?YUVmbk1oQzdPVDNValphYUxvc21OSkJtdXZaZ3lqeG83YlVsNlNpbzZOb0F2?=
 =?utf-8?B?bUhmMFFnYUdXaU9SVzRsUWEyR0tnbWJoaVhkOFZERFBGTFNkbEFXTGZ2VUpY?=
 =?utf-8?B?bjhLSm1KOWwvTGt2cVpld3pNTVhLMHR2QjhvaFlZNWNqN01yTnJ1VG5sdG0z?=
 =?utf-8?B?K2I0NXRFckdwcGhpam9WRTUvMkY5WWVFYUl2VmpsbFNxTkQ3KzNEVTdqTXky?=
 =?utf-8?B?elZucnJ6eThlTndVV1doQUpkVFVCZ0E1ZE1uejN4bEtQSDh4M0QzcnJZWEo0?=
 =?utf-8?B?eTVaQVNhSU9TM3VndE9mOVlWVlhHZlVCblNXcTVIS3A2VmVvQXdZRDRpNm15?=
 =?utf-8?B?dG1GcVc4MEVKdjdYb2RSUGtKNVhnMjUwN1pTQUVPYWt3SXhyMjFYaGVmQnhv?=
 =?utf-8?B?bktsUzRSS3RPTVd1SzQ0MDhXbkduVHVNcGh6dUJYSnhnS2UwZ29EclJwdlFY?=
 =?utf-8?B?WmxNV3JibWtYOFZLMTdqWWlrZStuSDdvbUZmY0lpQzlINGRMeUpld0hQRUpG?=
 =?utf-8?B?dXp4SExaODIrM2dtQWl4MGllSmFlb2ljNmVXcWdlOC9oRXFyMjM3eGNwYzla?=
 =?utf-8?B?ODhoaE16WkRNMmtFbnNld3MwM3IvZU9OcXBNTE9pVU1Dank1c0JMdGlRaERO?=
 =?utf-8?B?ZGtCZTJUQWU1MmlveXNqdk84MG9GWG90M2V1Zkx0LzBaamIyU0wwQnFnRjVl?=
 =?utf-8?B?cURnWkEwcUFST3pQbFhiSmtTSFRJTWMydk1XYkdVM1lZblVEc0RBZUd5aTMy?=
 =?utf-8?Q?/f9Yj/nivaZDYvsM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F54B0EFD88D7F45A575A319113B968E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63ca9de-7c3d-44d8-6313-08deb61ba084
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 02:58:10.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3CfBZcZJKgouquP5LbMfu5kbJ2z7ClG7A/8/54QFEVoOa0aDHcIbldJYrlzWloimieNPBMOS8nPcPdMB47X4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8318
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10567-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Queue-Id: 3D36C58700B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMTkvNS8yMDI2IDM6MTggcG0sIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFtZ
b3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gc2FzaGlrby1ib3RAa2VybmVsLm9yZy4gTGVh
cm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24h
IFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDMgcG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVy
Og0KPiAtIFtIaWdoXSBVbmJvdW5kZWQgYnVzeS13YWl0aW5nIHdpdGggbWRlbGF5KDEpIGluc2lk
ZSBhIGhhcmQgSVJRIGhhbmRsZXIgY2F1c2VzIHNldmVyZSBsYXRlbmN5IHNwaWtlcyBhbmQgaGFy
ZCBsb2NrdXBzLiAoUHJlLWV4aXN0aW5nIGlzc3VlKQ0KPiAtIFtIaWdoXSBDbGVhcmluZyB0aGUg
aW50ZXJydXB0IHN0YXR1cyBhZnRlciBzdGFydGluZyBhIG5ldyB0cmFuc2ZlciBjcmVhdGVzIGEg
cmFjZSBjb25kaXRpb24gbGVhZGluZyB0byBsb3N0IGludGVycnVwdHMgYW5kIGEgaHVuZyBETUEg
cGlwZWxpbmUuIChQcmUtZXhpc3RpbmcgaXNzdWUpDQo+IC0gW01lZGl1bV0gVGhlIHBhdGNoIGlu
dHJvZHVjZXMgZXhjZXNzaXZlIGhlYXZ5IG1lbW9yeSBiYXJyaWVycyBvbiB0aGUgRE1BIGZhc3Qg
cGF0aCBieSB1c2luZyBpb3dyaXRlMzIoKSBpbiBhIGxvb3AuDQo+IC0tDQo+DQo+IGNvbW1pdCA2
NGY0ZDI0Njk3NDRiNTdkMmNhNjRlNzhmOGNlZjIyOWRlMmM1ZWFlDQo+IEF1dGhvcjogQWRyaWFu
IE5nIEhvIFlpbiA8YWRyaWFuaG95aW4ubmdAYWx0ZXJhLmNvbT4NCj4NCj4gZG1hOiBhbHRlcmEt
bXNnZG1hOiBSZXBsYWNlIG1lbWNweSB3aXRoIGlvMzJ3cml0ZSBpbiBtc2dkbWFfY29weV9vbmUN
Cj4NCj4gVGhpcyBjb21taXQgcmVwbGFjZXMgbWVtY3B5KCkgd2l0aCBhbiBleHBsaWNpdCBpb3dy
aXRlMzIoKSBsb29wIHdoZW4NCj4gd3JpdGluZyBkZXNjcmlwdG9ycyBpbnRvIHRoZSBETUEgY29u
dHJvbGxlcidzIEZJRk8uIFRoaXMgZW5zdXJlcyB0aGF0DQo+IE1NSU8gd3JpdGVzIGFyZSBub3Qg
cmVvcmRlcmVkIGJ5IHRoZSBjb21waWxlciBvciBhcmNoaXRlY3R1cmUsIGd1YXJhbnRlZWluZw0K
PiB0aGF0IHRoZSBjb250cm9sIHdvcmQgaXMgYWx3YXlzIHdyaXR0ZW4gbGFzdC4NCj4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9hbHRlcmEtbXNnZG1hLmMgYi9kcml2ZXJzL2RtYS9hbHRl
cmEtbXNnZG1hLmMNCj4+IGluZGV4IGI0Njk5OWM4MWRmMDAuLjU4MTY5NzNkMmM3MGEgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL2RtYS9hbHRlcmEtbXNnZG1hLmMNCj4+ICsrKyBiL2RyaXZlcnMv
ZG1hL2FsdGVyYS1tc2dkbWEuYw0KPj4gQEAgLTQ5NSw2ICs0OTUsOSBAQCBzdGF0aWMgdm9pZCBt
c2dkbWFfY29weV9vbmUoc3RydWN0IG1zZ2RtYV9kZXZpY2UgKm1kZXYsDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgbXNnZG1hX3N3X2Rlc2MgKmRlc2MpDQo+PiAgIHsNCj4+
ICAgICAgICB2b2lkIF9faW9tZW0gKmh3X2Rlc2MgPSBtZGV2LT5kZXNjOw0KPj4gKyAgICAgY29u
c3QgdTMyICpzcmMgPSAoY29uc3QgdTMyICopJmRlc2MtPmh3X2Rlc2M7DQo+PiArICAgICB1bnNp
Z25lZCBpbnQgaSwgbndvcmRzID0gb2Zmc2V0b2Yoc3RydWN0IG1zZ2RtYV9leHRlbmRlZF9kZXNj
LCBjb250cm9sKSAvDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHUz
Mik7DQo+Pg0KPj4gICAgICAgIC8qDQo+PiAgICAgICAgICogQ2hlY2sgaWYgdGhlIERFU0MgRklG
TyBpdCBub3QgZnVsbC4gSWYgaXRzIGZ1bGwsIHdlIG5lZWQgdG8gd2FpdA0KPj4gQEAgLTUwNSwx
NiArNTA4LDE2IEBAIHN0YXRpYyB2b2lkIG1zZ2RtYV9jb3B5X29uZShzdHJ1Y3QgbXNnZG1hX2Rl
dmljZSAqbWRldiwNCj4+ICAgICAgICAgICAgICAgIG1kZWxheSgxKTsNCj4NCj4gVGhpcyBpc24n
dCBhIHJlZ3Jlc3Npb24gZnJvbSB0aGlzIHBhdGNoLCBidXQgY2FuIHRoaXMgdW5ib3VuZGVkIGJ1
c3ktd2FpdA0KPiBpbnNpZGUgYSBoYXJkIElSUSBoYW5kbGVyIGNhdXNlIHNldmVyZSBsYXRlbmN5
IHNwaWtlcyBhbmQgaGFyZCBsb2NrdXBzPw0KPg0KPiBJZiBhIGxhcmdlIHNjYXR0ZXItZ2F0aGVy
IGxpc3QgaXMgc3VibWl0dGVkIHRoYXQgZXhjZWVkcyB0aGUgaGFyZHdhcmUgRklGTw0KPiBzaXpl
LCBtc2dkbWFfc3RhcnRfdHJhbnNmZXIoKSB3aWxsIGF0dGVtcHQgdG8gcHVzaCBhbGwgb2YgdGhl
bSBhdCBvbmNlLg0KPiBUaGUgQ1BVIHdpbGwgc3BpbiBpbiBtZGVsYXkoMSkgZm9yIGVhY2ggc3Vi
c2VxdWVudCBkZXNjcmlwdG9yIHdoaWxlIHRoZSBETUENCj4gZW5naW5lIHByb2Nlc3NlcyB0aGUg
dHJhbnNmZXJzLg0KPg0KPiBXYWl0aW5nIGZvciBodW5kcmVkcyBvZiBtaWxsaXNlY29uZHMgd2l0
aCBJUlFzIGRpc2FibGVkIGNvdWxkIHRyaWdnZXIgYSBrZXJuZWwNCj4gaGFyZCBsb2NrdXAgd2F0
Y2hkb2cgcGFuaWMuIEZ1cnRoZXJtb3JlLCBpZiB0aGUgaGFyZHdhcmUgc3RhbGxzIGR1ZSB0byBh
IGJ1cw0KPiBlcnJvciwgdGhlIENQVSB3aWxsIHNwaW4gZm9yZXZlci4NCj4NCj4gV291bGQgaXQg
YmUgcG9zc2libGUgdG8gaW1wbGVtZW50IGEgcHJvcGVyIHRpbWVvdXQgbWVjaGFuaXNtIGFuZCBz
b2Z0d2FyZQ0KPiBxdWV1aW5nIGhlcmUgaW5zdGVhZD8NCj4NCj4gWyAuLi4gXQ0KPg0KPj4gLSAg
ICAgICogVGhlIGRlc2NyaXB0b3IgbmVlZHMgdG8gZ2V0IGNvcGllZCBpbnRvIHRoZSBkZXNjcmlw
dG9yIEZJRk8NCj4+IC0gICAgICAqIG9mIHRoZSBETUEgY29udHJvbGxlci4gVGhlIGRlc2NyaXB0
b3Igd2lsbCBnZXQgZmx1c2hlZCB0byB0aGUNCj4+IC0gICAgICAqIEZJRk8sIG9uY2UgdGhlIGxh
c3Qgd29yZCAoY29udHJvbCB3b3JkKSBpcyB3cml0dGVuLiBTaW5jZSB3ZQ0KPj4gLSAgICAgICog
YXJlIG5vdCAxMDAlIHN1cmUgdGhhdCBtZW1jcHkoKSB3cml0ZXMgYWxsIHdvcmQgaW4gdGhlICJj
b3JyZWN0Ig0KPj4gLSAgICAgICogb3JkZXIgKGFkZHJlc3MgZnJvbSBsb3cgdG8gaGlnaCkgb24g
YWxsIGFyY2hpdGVjdHVyZXMsIHdlIG1ha2UNCj4+IC0gICAgICAqIHN1cmUgdGhpcyBjb250cm9s
IHdvcmQgaXMgd3JpdHRlbiBsYXN0IGJ5IHNpbmdsZSBjb2RpbmcgaXQgYW5kDQo+PiAtICAgICAg
KiBhZGRpbmcgc29tZSB3cml0ZS1iYXJyaWVycyBoZXJlLg0KPj4gKyAgICAgICogVGhlIGRlc2Ny
aXB0b3IgbXVzdCBiZSB3cml0dGVuIGludG8gdGhlIGRlc2NyaXB0b3IgRklGTyBvZiB0aGUgRE1B
DQo+PiArICAgICAgKiBjb250cm9sbGVyLiBUaGUgRklGTyBpcyBmbHVzaGVkIGFuZCB0aGUgZGVz
Y3JpcHRvciBiZWNvbWVzIHZhbGlkIG9uY2UNCj4+ICsgICAgICAqIHRoZSBsYXN0IHdvcmQgKHRo
ZSBjb250cm9sIHdvcmQpIGlzIHdyaXR0ZW4uIFRvIGd1YXJhbnRlZSB0aGUgb3JkZXJpbmcNCj4+
ICsgICAgICAqIG9mIE1NSU8gd3JpdGVzIGFjcm9zcyBhbGwgYXJjaGl0ZWN0dXJlcywgd2Ugd3Jp
dGUgZWFjaCAzMi1iaXQgd29yZA0KPj4gKyAgICAgICogaW5kaXZpZHVhbGx5IHVzaW5nIGlvd3Jp
dGUzMigpLCBhbmQgaGFuZGxlIHRoZSBjb250cm9sIHdvcmQgc2VwYXJhdGVseQ0KPj4gKyAgICAg
ICogYXQgdGhlIGVuZC4gVGhpcyBlbnN1cmVzIHRoZSBjb250cm9sIHdvcmQgaXMgYWx3YXlzIHdy
aXR0ZW4gbGFzdCBhbmQNCj4+ICsgICAgICAqIHByZXZlbnRzIG1lbWNweSgpIG9yIHRoZSBjb21w
aWxlciBmcm9tIHJlb3JkZXJpbmcgYWNjZXNzZXMuDQo+PiAgICAgICAgICovDQo+PiAtICAgICBt
ZW1jcHkoKHZvaWQgX19mb3JjZSAqKWh3X2Rlc2MsICZkZXNjLT5od19kZXNjLA0KPj4gLSAgICAg
ICAgICAgIHNpemVvZihkZXNjLT5od19kZXNjKSAtIHNpemVvZih1MzIpKTsNCj4+ICsgICAgIGZv
ciAoaSA9IDA7IGkgPCBud29yZHM7IGkrKykNCj4+ICsgICAgICAgICAgICAgaW93cml0ZTMyKHNy
Y1tpXSwgaHdfZGVzYyArIGkgKiBzaXplb2YodTMyKSk7DQo+DQo+IERvZXMgdGhpcyBpbnRyb2R1
Y2UgZXhjZXNzaXZlIGhlYXZ5IG1lbW9yeSBiYXJyaWVycyBvbiB0aGUgRE1BIGZhc3QgcGF0aD8N
Cj4NCj4gVGhlIGlvd3JpdGUzMigpIG1hY3JvIG1hcHMgdG8gd3JpdGVsKCksIHdoaWNoIGluY2x1
ZGVzIGFuIGltcGxpY2l0IGhlYXZ5DQo+IG1lbW9yeSBiYXJyaWVyIGJlZm9yZSB0aGUgd3JpdGUg
dG8gZW5zdXJlIG1lbW9yeSBhY2Nlc3NlcyBhcmUgdmlzaWJsZSB0byB0aGUNCj4gZGV2aWNlLg0K
Pg0KPiBFeGVjdXRpbmcgdGhpcyBiYXJyaWVyIGluIGEgdGlnaHQgbG9vcCBmb3IgZXZlcnkgd29y
ZCBvZiB0aGUgRE1BIGRlc2NyaXB0b3INCj4gY291bGQgc2lnbmlmaWNhbnRseSBkZWdyYWRlIHBl
cmZvcm1hbmNlIG9uIHRoZSBzdWJtaXNzaW9uIGhvdCBwYXRoLg0KPg0KPiBTaW5jZSB0aGUgaGFy
ZHdhcmUgbWVyZWx5IHJlcXVpcmVzIHRoZSBkZXNjcmlwdG9yIHdvcmRzIHRvIGJlIHdyaXR0ZW4N
Cj4gc2VxdWVudGlhbGx5IGJlZm9yZSB3cml0aW5nIHRoZSBmaW5hbCBjb250cm9sIHdvcmQsIGNv
dWxkIHdyaXRlbF9yZWxheGVkKCkNCj4gYmUgdXNlZCBpbnN0ZWFkIHRvIGF2b2lkIHRoZSBwZXIt
d29yZCBiYXJyaWVyIG92ZXJoZWFkPyBBbiBleHBsaWNpdCB3bWIoKQ0KPiBpcyBhbHJlYWR5IHBy
ZXNlbnQgYmVmb3JlIHRoZSBmaW5hbCBjb250cm9sIHdvcmQgd3JpdGUgdG8gZW5zdXJlIGNvcnJl
Y3QNCj4gb3JkZXJpbmcuDQo+DQo+IFRoaXMgaXNuJ3QgYSByZWdyZXNzaW9uIGZyb20gdGhpcyBw
YXRjaCwgYnV0IGNvdWxkIGNsZWFyaW5nIHRoZSBpbnRlcnJ1cHQNCj4gc3RhdHVzIGFmdGVyIHN0
YXJ0aW5nIGEgbmV3IHRyYW5zZmVyIGNyZWF0ZSBhIHJhY2UgY29uZGl0aW9uIGxlYWRpbmcgdG8N
Cj4gbG9zdCBpbnRlcnJ1cHRzIGFuZCBhIGh1bmcgRE1BIHBpcGVsaW5lPw0KPg0KPiBkcml2ZXJz
L2RtYS9hbHRlcmEtbXNnZG1hLmM6bXNnZG1hX2lycV9oYW5kbGVyKCkgew0KPiAgICAgICAgICBp
ZiAoKHN0YXR1cyAmIE1TR0RNQV9DU1JfU1RBVF9CVVNZKSA9PSAwKSB7DQo+ICAgICAgICAgICAg
ICAgICAgLyogU3RhcnQgbmV4dCB0cmFuc2ZlciBpZiB0aGUgRE1BIGNvbnRyb2xsZXIgaXMgaWRs
ZSAqLw0KPiAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmbWRldi0+bG9jayk7DQo+ICAgICAg
ICAgICAgICAgICAgbWRldi0+aWRsZSA9IHRydWU7DQo+ICAgICAgICAgICAgICAgICAgbXNnZG1h
X3N0YXJ0X3RyYW5zZmVyKG1kZXYpOw0KPiAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZt
ZGV2LT5sb2NrKTsNCj4gICAgICAgICAgfQ0KPg0KPiAgICAgICAgICB0YXNrbGV0X3NjaGVkdWxl
KCZtZGV2LT5pcnFfdGFza2xldCk7DQo+DQo+ICAgICAgICAgIC8qIENsZWFyIGludGVycnVwdCBp
biBtU0dETUEgY29udHJvbGxlciAqLw0KPiAgICAgICAgICBpb3dyaXRlMzIoTVNHRE1BX0NTUl9T
VEFUX0lSUSwgbWRldi0+Y3NyICsgTVNHRE1BX0NTUl9TVEFUVVMpOw0KPiB9DQo+DQo+IElmIHRo
ZSBuZXdseSBzdGFydGVkIERNQSB0cmFuc2ZlciBjb21wbGV0ZXMgZXh0cmVtZWx5IHF1aWNrbHks
IGJlZm9yZSB0aGUNCj4gQ1BVIHJlYWNoZXMgdGhlIGlvd3JpdGUzMigpIGluc3RydWN0aW9uLCB0
aGUgaGFyZHdhcmUgd2lsbCBhc3NlcnQgdGhlIElSUQ0KPiBiaXQgYWdhaW4uDQo+DQo+IFRoZSB1
bmNvbmRpdGlvbmFsIGNsZWFyIHdpbGwgdGhlbiBjbGVhciB0aGlzIG5ldyBpbnRlcnJ1cHQgZXZl
bnQsIGFuZCBiZWNhdXNlDQo+IHRoZSBldmVudCBpcyBsb3N0LCB0aGUgdGFza2xldCB3aWxsIG5v
dCBiZSBzY2hlZHVsZWQgZm9yIHRoZSBzZWNvbmQgdHJhbnNmZXIuDQo+DQo+IE9uIHN5c3RlbXMg
d2l0aG91dCBhIHJlc3BvbnNlIEZJRk8sIHRoZSB0YXNrbGV0IGNvbXBsZXRlcyBleGFjdGx5IG9u
ZQ0KPiBkZXNjcmlwdG9yIHBlciBydW4sIHNvIGxvc2luZyB0aGUgaW50ZXJydXB0IGNvdWxkIHN0
cmFuZCB0aGUgc2Vjb25kIGRlc2NyaXB0b3INCj4gaW4gdGhlIGFjdGl2ZV9saXN0IHBlcm1hbmVu
dGx5Lg0KPg0KPiBTaG91bGQgdGhlIGludGVycnVwdCBzdGF0dXMgYmUgY2xlYXJlZCBiZWZvcmUg
aW5pdGlhdGluZyB0aGUgbmV4dCB0cmFuc2Zlcj8NCj4NCj4gLS0NCj4gU2FzaGlrbyBBSSByZXZp
ZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzQ1ODZjMzliNDNhYTNiOTQ4MDk4
OTk0MGZlOTA1ZGFjNDBjOGNlZmMuMTc3OTE3MzE1Ni5naXQudHplLnllZS5uZ0BhbHRlcmEuY29t
P3BhcnQ9MQ0KDQpIaSBtYWludGFpbmVycywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpU
aGlzIHBhdGNoIG9ubHkgcmVwbGFjZXMgbWVtY3B5KCkgd2l0aCBvcmRlcmVkIHBlci13b3JkIE1N
SU8gd3JpdGVzIGZvcg0KdGhlIGRlc2NyaXB0b3IgRklGTzsgaXQgZG9lcyBub3QgY2hhbmdlIHRo
ZSBtZGVsYXkoKSBGSUZPIGJhY2stcHJlc3N1cmUNCmxvb3Agb3IgbXNnZG1hX2lycV9oYW5kbGVy
KCkgKGFjayBvcmRlcmluZyAvIG1zZ2RtYV9zdGFydF90cmFuc2ZlcigpIGluDQpoYXJkaXJxKS4g
VGhvc2UgaXNzdWVzIHByZWRhdGUgdGhpcyBzZXJpZXPigJRJIGNhbiBzZW5kIHNlcGFyYXRlIGZp
eGVzIGlmDQp5b3Ugd2FudCB0aGVtLCBidXQgSSdkIHByZWZlciBub3QgdG8gbWl4IHRoZW0gaW50
byB0aGlzIGNvcnJlY3RuZXNzIHBhdGNoLg0KDQpPbiBpb3dyaXRlMzIoKSB2cyB3cml0ZWxfcmVs
YXhlZCgpOiB0aGUgd2hvbGUgZHJpdmVyIHVzZXMNCmlvcmVhZDMyL2lvd3JpdGUzMiB0b2RheSAo
bm8gX3JlbGF4ZWQgYW55d2hlcmUpLiBJIHVzZWQgaW93cml0ZTMyKCkgdG8NCm1hdGNoIHRoYXQg
YW5kIHRvIGJlIGNvbnNlcnZhdGl2ZSBvbiBvcmRlcmluZy4gSWYgeW91IHByZWZlcg0Kd3JpdGVs
X3JlbGF4ZWQoKSBmb3IgdGhlIGJvZHkgd29yZHMgcGx1cyB3bWIoKSBiZWZvcmUgdGhlIGNvbnRy
b2wgd29yZCwNCkknbSBoYXBweSB0byBkbyB0aGF0IGhlcmUgb3IgaW4gYSBxdWljayBmb2xsb3ct
dXAgb25jZSB5b3UgY29uZmlybQ0KdGhhdCdzIHNhZmUgZm9yIHRoaXMgSVAuDQoNClBsZWFzZSBs
ZXQgbWUga25vdyB3aGljaCBhcHByb2FjaCB5b3UgcHJlZmVyLg0KDQpUaGFua3MsDQpUemUgWWVl
DQo=

