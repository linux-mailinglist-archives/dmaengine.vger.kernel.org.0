Return-Path: <dmaengine+bounces-11411-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lad9BDcYKmrBigMAu9opvQ
	(envelope-from <dmaengine+bounces-11411-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 04:06:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E2366DBE0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 04:06:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=DZRGd8lK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11411-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11411-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8C6D30C4307
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 02:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497E21A92F;
	Thu, 11 Jun 2026 02:06:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61951204F93
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 02:06:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143604; cv=fail; b=JOhC2Bh3aZFVPZstAT1ZrM+Gjt9+RmILKX+3bviC0hy/fs+8aXZkmHKY3NqTpQmQwugs9I4ZWt7U7QP1ug5CmCXaHxtr4K4Pp5GQvQzIjJF9eRFbSt8mBBIf2B37Tc9qJE2MMIIrnKBm1KZ5/au//n1a/1u7rezOT/FwBp/klzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143604; c=relaxed/simple;
	bh=/AwHGu9gvu2nfMonh8gVVSOfrwHgEOL4CHcziuAM8C0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UEDue5+VQfvIaCJZFRjpL+cyk5yDap1yPxCVsZu5FANFEi0qvz/FJQPB8OavZka7cGwpqNggc4vIROFDOFRYrt5SgdEkvZubn8Us4VF6tSOr9QHHk0HiYUXz4nCvRgdXeq+P8LNVJ5AqQKxjTU+ys98PvQpq8xVa0BdJaze72hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DZRGd8lK; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv0leyvj+2x3sU0zr+K/pp/rr7OxEIpzctuM5LO+GWldQKQ55srarFMlPfU7mPdOon/W0FfHnBsuZXJH80NVUSvpSM5hn80ULgTY1m7WjwplZHWgtFQrHe0GI3NCc8T7MvRkA85lk7v3keUgR4nlCutqV10DXzIQnk1BlxrZnOPLkEJeHxYajobDEshojLU7VoCttao9DC/udrv+jcQrnOA2IbCCTCbzZxzWxOQmqDVxGEOz7pI8LZqthnPP5ObX+mlTep4QMROgIVcPRCfsp5DfeYXFQOOkww7+bZRJlwFGdlQvQKWmlBVk+gX5yBeUV9pzbTdTrPFArzyNg73CWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AwHGu9gvu2nfMonh8gVVSOfrwHgEOL4CHcziuAM8C0=;
 b=wJVaxWz4bAM8wBa8gYy31huRKDUXbUIfXytcW9AeDsW9+uLP2mnDhcI3VWEROf5vKggM/S2H53EMWysnKo1bg7+L9uzK+q+ctv+hRW2XvGh/4F0LJwwySw7Hz8P9w2U5G4+u4av9fW+iuvTnXPdYyRfvchJ7PwBZyj658e3/dn6p5l2dtwCIMU3mmDULxKtnLrnb9i7cy+QBgMF5QRN9DSJFZH5QO+aFY43mexzLnzLfogOJLGkKik1FisOtCZma8AtJxM/qrC0q1JEwhoR7u2lDgCjw2PVptojz1D1tXEeHhn+59h62oX912+ZURUc0H46f+lUhDBWVuTkV/aZueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AwHGu9gvu2nfMonh8gVVSOfrwHgEOL4CHcziuAM8C0=;
 b=DZRGd8lKZY62UBHUZ1EDBeftZzDY1cIEXp3OZMS8xgc3OvkYP0vlpkAoPnZF8QE+iSEdvsrDbb1KWzi2mwRlgwU91vc1KUVkRF/bK1eT4/aGO8K6T4fz/ILLz2D3emgligRM6/Y51CCXEHgGWotD0pR2+g5hw223iCAt0UpdChz2Hmzkk8PSurzMm/eWK/5ROgAwieo42kKCdRXFYnQQzxyb1Nd+YXJXF2xE11q5avsyUrACKWqieoMdqDxB1Mju+DESUonD+s9dLwVzTFeXxoAcV76v38pkLmORB36ejns5fQ/C1bmp7eXThSqvnMoabzyMXmOZ9+etd+FZN6jB5A==
Received: from SJ0PR03MB5951.namprd03.prod.outlook.com (2603:10b6:a03:2de::13)
 by CH4PR03MB7556.namprd03.prod.outlook.com (2603:10b6:610:240::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 11 Jun 2026
 02:06:39 +0000
Received: from SJ0PR03MB5951.namprd03.prod.outlook.com
 ([fe80::f285:8376:68af:6acf]) by SJ0PR03MB5951.namprd03.prod.outlook.com
 ([fe80::f285:8376:68af:6acf%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 02:06:39 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, Frank Li <Frank.li@nxp.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, Olivier Dautricourt
	<olivierdautricourt@gmail.com>, Stefan Roese <sr@denx.de>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor
 FIFO writes
Thread-Topic: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor
 FIFO writes
Thread-Index: AQHc7CG60nndVcDxp0WjWCcKmwC0WrYeb48AgAASO4CABElbAIAV6ncA
Date: Thu, 11 Jun 2026 02:06:39 +0000
Message-ID: <8ec1bca9-851c-4b6f-a85b-52867d824f84@altera.com>
References:
 <f6f3b4a2e2eb0eb1a51976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com>
 <20260525085311.1C2341F000E9@smtp.kernel.org>
 <621a83f5-140e-4947-ba9a-5eeef8b4148a@altera.com>
 <79e200dd-6071-4443-90a7-db915175100a@altera.com>
In-Reply-To: <79e200dd-6071-4443-90a7-db915175100a@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5951:EE_|CH4PR03MB7556:EE_
x-ms-office365-filtering-correlation-id: c3276995-f585-42e3-2855-08dec75e12fc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|6133799003|22082099003|18002099003|3023799007|4143699003|38070700021|55112099003;
x-microsoft-antispam-message-info:
 w2sb715vimS7GnKTFGEYa3pO3VlF3G48pFXjKE0Bxpwv07mb5hGnNSD4JZJ+hd0WxeMgdRIWfErgLNMrLJm+d8Q+HRNO/xt55cV8MdHyKbGL9X+U6uJ+ezH4UOo741AxhtUUqI77O0WA6AHjSTvFfnsfZqIXUemdOcaX+YraTN19/vN8d20ITRfmJzFhilW9jfodExLhN4ITgE3NPejCOQyJSVtbRDoCMpx6UymVzX8+1fs/xbA25cpUIlqKp7WK6oo7xQEvz9L57oKdD7vu4By5Jjrb70GMfWsHXNb12J3YWYtPcmN+MhCDjpyMMaibp9VFHOnHmxeCr3yMuW+ro3BPNFv9vaAfia9v4kMjN7LPcQzI5d38ItpPDS6mv9U60Ifj+uetyQP+KVT9iPfc/6lL/0xk3FQfpxU5ZepYUf2WiLmrvy3oK0bqyLoFZtmJ8TU5nmglmymwR5fJzF5JNvv51XJmXVBiQl7sF+qyKRRrXdHjHLTB/f0X353TZvmtb/g+IBcA6lQCI/7xd5ZlkSKZUeEEornL7N29mxPn4FcYK8pPEqDV2V7prKCxwmzzfqJprba30tOBvu/10REuYXGLEIOyW9PUhRs014HKAx0Gkb1NBXcevEFfq0a36UXSOCH82ov6PVGJwDsvTmkHJ12g8eR6TWaNvWSAlsdScNTwwQ8xaEhrQD7BPAim8UMEWErVuLFwDTMRyHo6tzLKuoZ0RWhfxLIxQ3e4bbTd0AYLJCZv7ar4vcp8mu0IdjM3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5951.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003)(38070700021)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXkxY3VKNFlIRk44ejBEc2pML1pJNGpmRUJXaTBhd00xcm9vQWphQ2Jud0pX?=
 =?utf-8?B?R3ZYT1hkRHVCbHRpSThCbzM3c09iemU5ZXZ2MkxvbXJnNElJQzVpNkQ4YjRV?=
 =?utf-8?B?RGhkdldOYUgrY0hFOUZheEJobXl2cmVHc3hpak1BNXlDZ3FWb1FtcVJQT3Q4?=
 =?utf-8?B?OVkvcks3QVRlcVdiL0FXK1J0REZWT3B3cUFBMHI5aEdrSWljc1ZpSUsrWFIr?=
 =?utf-8?B?YThia0Nzbk10MGtsYVZ4bWo1aWxMSjBmSDdBVXd0d3lGRnlpd3hrZEdmQ092?=
 =?utf-8?B?Q0VTa1lCYjNNUHp3aGFMYlNhSGhscGt3RWZsSnUyejV3emRxcHM0YXBHR3A2?=
 =?utf-8?B?VVNsaForRWc5cE9yYXJRb1p1T3d0Y3UxVFlwQUNvQWNEcHhVOUlERytXUEl0?=
 =?utf-8?B?Ky94dWtDanlCa0VBcFB0cXB5MnM2Vm5mckIyZlpPbTZHVmdVYzN3K0wzZzYx?=
 =?utf-8?B?MEgranhuMWVsNERFUlZoRU1VdEpwZ2lsYkdxRG53cnM2ZU1qalVXOHdzOXFC?=
 =?utf-8?B?WXdUUmFocEJCSmMvTmhDbWpIT2RvZEJMcTNHZXZOeVBSbmF3NVp0TjBCSEtX?=
 =?utf-8?B?SVNOL3JMcy9XZWswZXNRVGdETGNGUnVmWmdZK1RlUWZFbXFKSHVRdkNubTF0?=
 =?utf-8?B?TWJyY0lsMzg5MTJhWkJ0SlkyQlc2bE9OQUdXUEM3MzBQbWZPaStUajRZU1Jh?=
 =?utf-8?B?dEtEeFhFK1BkUmUzSGNUNHc4QUtYNVFwcFdFTit1MG5HRjBnZ25WbmR4K3ZM?=
 =?utf-8?B?K2pRU3poek5QdFhVeWFUUVZHZmhHQ2g3Qm8wUWs0bHE2UmM5eWt1Qi95TDlL?=
 =?utf-8?B?djlaYi9sbzEyR0JqcnJqaEtGUnNLNHBranhOanhRN0pHZTdRZkgxVUJnUkJu?=
 =?utf-8?B?QUgzem5ZVHBTVS9iNmJPaUY1TE1RWm9aSy9ZVjNwdUJaZWdXbExsaHBKZEIy?=
 =?utf-8?B?eERSd1F5YXI5blI5TVR0QmhTYUhkT2JSTVdlTTA0QkE0NWM1b20vZkJwdXlJ?=
 =?utf-8?B?T1F6Y0VsTm1OM3pQWGVNM1VlNjF2aGM4NTZndE1WY1NBQUs1M3ZsOFJxOHpu?=
 =?utf-8?B?VEFkakJQV3NNajBnb2szNlMxTUNYc2RyMXhndXpKQ28wSlN0R2tJczhHbmdV?=
 =?utf-8?B?YjNMNFNhL21VS2pOMk1XamNoNWFkVlVScXlWMGJDOTBBVGI0TFRYWnMxR3BX?=
 =?utf-8?B?SFo2d0p0UnR0a2c0NklpOGpueDhKdjkxclJBL1daR2d6UzZKYmVQS2pPeFJB?=
 =?utf-8?B?NEM5VHRoQWJVN1JMS1FoSkxENVI5R25QWS8wSElHUjMxRDhZVFd2VDFiK0wy?=
 =?utf-8?B?elRLV1Evd0tBZFhKQW43b003SksyM3VGc0tFR2Jqcjc2TDBLcWdrb1pMUTIz?=
 =?utf-8?B?QnhiaUR4VmNYLzNqUFdzRXlBSXpmaFFCMFFXNkVvOTJnTkt2T1FOUThyRE43?=
 =?utf-8?B?a0VPelJaaXp6bXkrdlhiMnpXYXFQbFVac244L2xGanlLcmJHdGR1cEhXNnRi?=
 =?utf-8?B?cGhEVFlPclI3dDZ6dWxDNENpbGx4Nld4d3cwY3Ezem03MlU3YlRJYWVLQWF0?=
 =?utf-8?B?TzlxaXVCY2dRaXJwTndHeCtJV2w0UFpDSlBhckxrNm5zZmdhcGFSMVl4YXov?=
 =?utf-8?B?QlE3TGVYc1QvMGxtcC8vUVhKRnpJbEZPcGU1cWc4SXNVS1diNkRTcGQzM3Mv?=
 =?utf-8?B?TDYvajlLcUpFdEQzWEFYNnFBTWpGV0ZkR3pJeHJkTEg3ZzgwcnNualp2OFl1?=
 =?utf-8?B?cVg1SFBNUXBmK3htNUhadGpxSUtlUWxpYWpQZ2Q0RU85TWx1d2ZxbEs0T1hI?=
 =?utf-8?B?TmFDVFJUbllqZk1PRC9sclpvT2YwN1hrbUtwNHAxZzNHMkdkeUdLQXNyUndG?=
 =?utf-8?B?SnJBRjJGWC9ESWlaRFVTdGdnYUxyZFJhTDIxTjg1UHhyTFNISG13cHp0dHpp?=
 =?utf-8?B?NnN3dG9waUxVRHNYM3FQbVN1ZzRtallzOExMd3pQUVI3NGNNam1VM0xGYURi?=
 =?utf-8?B?VTlLR1YxR0NJZFZtSytEbXJsU1FQRGszZG9YdzRHc2NaeVc2dTN4c3h3VkZW?=
 =?utf-8?B?dnh2Nm5xUVdRZkRicGgvSkVCSGs1WkozR3prZGNBS0ZXaHY3VGYvODhoYVNv?=
 =?utf-8?B?cjVKNEFuc3V6ZWVKWWZaQ2kvWHp5V3RRamxuVG5pblozY0FueEV0aURING5x?=
 =?utf-8?B?RlpOckxDZXd5MkY2WG5XME5SRDJYTTdpUS9EaEFwVVRRQnRsSFVNVjZHamth?=
 =?utf-8?B?NTJ0TjZFSERlREV1RWUwd2FrUTBjU01Edk56TUhpc0FrbVBkNE9DMWNoYzFw?=
 =?utf-8?B?SEg3ZThvSnRPMTZkUDJGOTBKU1l1c3MrWGhzUURiQ01weXRTWFNGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE75F67AF2E03947B5F72A69E34421C5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5951.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3276995-f585-42e3-2855-08dec75e12fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 02:06:39.2537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBCCgnmHJcc5VoUcgHnU4L2VznhK31Ppbp5HKZxxtYKVbofhY0YdNxv/IJmCFYGRha1EU7GSPerd8NT8YXNSnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7556
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,denx.de,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-11411-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:Frank.li@nxp.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:olivierdautricourt@gmail.com,m:sr@denx.de,m:sashiko-reviews@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57E2366DBE0

T24gMjgvNS8yMDI2IDExOjI2IGFtLCBOZywgVHplIFllZSB3cm90ZToNCj4gT24gMjUvNS8yMDI2
IDU6NTggcG0sIE5HLCBUWkUgWUVFIHdyb3RlOg0KPj4gT24gMjUvNS8yMDI2IDQ6NTMgcG0sIHNh
c2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+Pj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRy
aWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgNCBwb3RlbnRpYWwgDQo+Pj4gaXNzdWUo
cykgdG8gY29uc2lkZXI6DQo+Pj4NCj4+PiBOZXcgaXNzdWVzOg0KPj4+IC0gW0xvd10gVGhlIHBh
dGNoIGluYWR2ZXJ0ZW50bHkgZHVwbGljYXRlcyB0aGUgYHN0YXRpY19hc3NlcnRgIGJsb2NrIA0K
Pj4+IGZvciB0aGUgY29udHJvbCBmaWVsZCBvZmZzZXQuDQo+Pj4NCj4+PiBQcmUtZXhpc3Rpbmcg
aXNzdWVzOg0KPj4+IC0gW0hpZ2hdIE1peGVkIHVzYWdlIG9mIGBtZW1jcHlfdG9pbygpYCBhbmQg
YGlvd3JpdGUzMigpYCB3aGVuIA0KPj4+IHdyaXRpbmcgdG8gdGhlIGRlc2NyaXB0b3IgTU1JTyBG
SUZPIHJlc3VsdHMgaW4gaW5jb25zaXN0ZW50IA0KPj4+IGVuZGlhbm5lc3MgYmVoYXZpb3Igb24g
YmlnLWVuZGlhbiBhcmNoaXRlY3R1cmVzLg0KPj4+IC0gW0hpZ2hdIGBtZW1jcHlfdG9pbygpYCBk
b2VzIG5vdCBndWFyYW50ZWUgdGhlIHN0cmljdGx5IHNlcXVlbnRpYWwgDQo+Pj4gMzItYml0IGFj
Y2Vzc2VzIHJlcXVpcmVkIGJ5IHRoZSBoYXJkd2FyZSBkZXNjcmlwdG9yIEZJRk8uDQo+Pj4gLSBb
SGlnaF0gVGhlIGRyaXZlciBwb2xscyB0aGUgZGVzY3JpcHRvciBidWZmZXIgc3RhdHVzIGluZGVm
aW5pdGVseSANCj4+PiB1c2luZyBgbWRlbGF5KClgLCB3aGljaCBjYW4gaGFuZyB0aGUgc3lzdGVt
IGlmIHRoZSBoYXJkd2FyZSBzdGFsbHMuDQo+Pj4gLS0gDQo+Pj4NCj4+PiBjb21taXQgMDc3NDg4
ZmU1Y2JhMGE3ZjBjODQxMGQ2OWU1Y2IwZjY4OGU2NTQ4NQ0KPj4+IEF1dGhvcjogQWRyaWFuIE5n
IEhvIFlpbiA8YWRyaWFuaG95aW4ubmdAYWx0ZXJhLmNvbT4NCj4+Pg0KPj4+IGRtYTogYWx0ZXJh
LW1zZ2RtYTogVXNlIG1lbWNweV90b2lvIGZvciBkZXNjcmlwdG9yIEZJRk8gd3JpdGVzDQo+Pj4N
Cj4+PiBUaGlzIGNvbW1pdCByZXBsYWNlcyB0aGUgZm9yY2VkIF9faW9tZW0gbWVtY3B5KCkgd2l0
aCBtZW1jcHlfdG9pbygpIGZvcg0KPj4+IGNvcHlpbmcgZGVzY3JpcHRvciBib2RpZXMgdG8gdGhl
IGRtYSBlbmdpbmUgZmlmby4gSXQgYWxzbyBpbnRyb2R1Y2VzIGENCj4+PiBzdGF0aWNfYXNzZXJ0
IHRvIGVuc3VyZSB0aGUgY29udHJvbCB3b3JkIGlzIHRoZSBsYXN0IGZpZWxkIGluIHRoZSANCj4+
PiBzdHJ1Y3QsDQo+Pj4gYXMgd3JpdGluZyB0aGUgY29udHJvbCB3b3JkIGZsdXNoZXMgdGhlIGZp
Zm8uDQo+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2FsdGVyYS1tc2dkbWEuYyBi
L2RyaXZlcnMvZG1hL2FsdGVyYS1tc2dkbWEuYw0KPj4+PiBpbmRleCBiNDY5OTljODFkZjAwLi5l
MjNlNWI0NDFhMjRlIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2RtYS9hbHRlcmEtbXNnZG1h
LmMNCj4+Pj4gKysrIGIvZHJpdmVycy9kbWEvYWx0ZXJhLW1zZ2RtYS5jDQo+Pj4+IEBAIC00OTYs
NiArNDk2LDExIEBAIHN0YXRpYyB2b2lkIG1zZ2RtYV9jb3B5X29uZShzdHJ1Y3QgDQo+Pj4+IG1z
Z2RtYV9kZXZpY2UgKm1kZXYsDQo+Pj4+IMKgIHsNCj4+Pj4gwqDCoMKgwqDCoCB2b2lkIF9faW9t
ZW0gKmh3X2Rlc2MgPSBtZGV2LT5kZXNjOw0KPj4+PiArwqDCoMKgIC8qIEVuc3VyZSBjb250cm9s
IGlzIHRoZSBsYXN0IGZpZWxkIOKAlCByZXF1aXJlZCBmb3IgY29ycmVjdCBGSUZPIA0KPj4+PiBm
bHVzaCBvcmRlcmluZyAqLw0KPj4+PiArwqDCoMKgIHN0YXRpY19hc3NlcnQob2Zmc2V0b2Yoc3Ry
dWN0IG1zZ2RtYV9leHRlbmRlZF9kZXNjLCBjb250cm9sKSA9PQ0KPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCBtc2dkbWFfZXh0ZW5kZWRfZGVzYykgLSBzaXpl
b2YodTMyKSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJjb250cm9sIG11c3Qg
YmUgdGhlIGxhc3QgZmllbGQgaW4gDQo+Pj4+IG1zZ2RtYV9leHRlbmRlZF9kZXNjIik7DQo+Pj4+
ICsNCj4+Pj4gwqDCoMKgwqDCoCAvKg0KPj4+PiDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGUg
REVTQyBGSUZPIGl0IG5vdCBmdWxsLiBJZiBpdHMgZnVsbCwgd2UgbmVlZCB0byANCj4+Pj4gd2Fp
dA0KPj4+PiDCoMKgwqDCoMKgwqAgKiBmb3IgYXQgbGVhc3Qgb25lIGVudHJ5IHRvIGJlY29tZSBm
cmVlIGFnYWluDQo+Pj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4+PiDCoMKgwqDCoMKgIHdoaWxlIChp
b3JlYWQzMihtZGV2LT5jc3IgKyBNU0dETUFfQ1NSX1NUQVRVUykgJg0KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgTVNHRE1BX0NTUl9TVEFUX0RFU0NfQlVGX0ZVTEwpDQo+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBtZGVsYXkoMSk7DQo+Pj4NCj4+PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+Pj4g
VGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1ZSwgYnV0IGRvZXMgdGhpcyBsb29wIHJpc2sgYSBo
YXJkIGtlcm5lbCANCj4+PiBsb2NrdXA/DQo+Pj4NCj4+PiBTaW5jZSB0aGlzIGZ1bmN0aW9uIGV4
ZWN1dGVzIHdoaWxlIGhvbGRpbmcgYSBzcGlubG9jayBkdXJpbmcgdGhlIGlycSANCj4+PiBoYW5k
bGVyOg0KPj4+DQo+Pj4gbXNnZG1hX2lycV9oYW5kbGVyKCktPm1zZ2RtYV9zdGFydF90cmFuc2Zl
cigpLT5tc2dkbWFfY29weV9vbmUoKQ0KPj4+DQo+Pj4gcG9sbGluZyBpbmRlZmluaXRlbHkgd2l0
aCBtZGVsYXkoKSB3aXRob3V0IGEgdGltZW91dCBjb3VsZCB3ZWRnZSB0aGUgY3B1DQo+Pj4gaWYg
dGhlIGhhcmR3YXJlIGZhaWxzIHRvIGRyYWluIHRoZSBkZXNjcmlwdG9yIGZpZm8uIFNob3VsZCB0
aGlzIHVzZSBhDQo+Pj4gcHJvcGVyIHRpbWVvdXQgbG9vcCBsaWtlIHJlYWRsX3BvbGxfdGltZW91
dF9hdG9taWMoKSBpbnN0ZWFkPw0KPj4+DQo+Pj4+ICvCoMKgwqAgLyogRW5zdXJlIGNvbnRyb2wg
aXMgdGhlIGxhc3QgZmllbGQg4oCUIHJlcXVpcmVkIGZvciBjb3JyZWN0IEZJRk8gDQo+Pj4+IGZs
dXNoIG9yZGVyaW5nICovDQo+Pj4+ICvCoMKgwqAgc3RhdGljX2Fzc2VydChvZmZzZXRvZihzdHJ1
Y3QgbXNnZG1hX2V4dGVuZGVkX2Rlc2MsIGNvbnRyb2wpID09DQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgbXNnZG1hX2V4dGVuZGVkX2Rlc2MpIC0gc2l6ZW9mKHUz
MiksDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJjb250cm9sIG11c3QgYmUgdGhlIGxh
c3QgZmllbGQgaW4gbXNnZG1hX2V4dGVuZGVkX2Rlc2MiKTsNCj4+Pj4gKw0KPj4+DQo+Pj4gW1Nl
dmVyaXR5OiBMb3ddDQo+Pj4gSXMgdGhpcyByZWdyZXNzaW9uIGEgY29weS1wYXN0ZSBlcnJvcj8g
VGhlIGV4YWN0IHNhbWUgc3RhdGljX2Fzc2VydCBhbmQNCj4+PiBjb21tZW50IHdlcmUgYWxzbyBh
ZGRlZCBqdXN0IGJlZm9yZSB0aGUgd2hpbGUgbG9vcCBpbiB0aGlzIHBhdGNoLg0KPj4+DQo+Pj4+
IMKgwqDCoMKgwqAgLyoNCj4+Pj4gLcKgwqDCoMKgICogVGhlIGRlc2NyaXB0b3IgbmVlZHMgdG8g
Z2V0IGNvcGllZCBpbnRvIHRoZSBkZXNjcmlwdG9yIEZJRk8NCj4+Pj4gLcKgwqDCoMKgICogb2Yg
dGhlIERNQSBjb250cm9sbGVyLiBUaGUgZGVzY3JpcHRvciB3aWxsIGdldCBmbHVzaGVkIHRvIHRo
ZQ0KPj4+PiAtwqDCoMKgwqAgKiBGSUZPLCBvbmNlIHRoZSBsYXN0IHdvcmQgKGNvbnRyb2wgd29y
ZCkgaXMgd3JpdHRlbi4gU2luY2Ugd2UNCj4+Pj4gLcKgwqDCoMKgICogYXJlIG5vdCAxMDAlIHN1
cmUgdGhhdCBtZW1jcHkoKSB3cml0ZXMgYWxsIHdvcmQgaW4gdGhlIA0KPj4+PiAiY29ycmVjdCIN
Cj4+Pj4gLcKgwqDCoMKgICogb3JkZXIgKGFkZHJlc3MgZnJvbSBsb3cgdG8gaGlnaCkgb24gYWxs
IGFyY2hpdGVjdHVyZXMsIHdlIG1ha2UNCj4+Pj4gLcKgwqDCoMKgICogc3VyZSB0aGlzIGNvbnRy
b2wgd29yZCBpcyB3cml0dGVuIGxhc3QgYnkgc2luZ2xlIGNvZGluZyBpdCBhbmQNCj4+Pj4gLcKg
wqDCoMKgICogYWRkaW5nIHNvbWUgd3JpdGUtYmFycmllcnMgaGVyZS4NCj4+Pj4gK8KgwqDCoMKg
ICogQ29weSB0aGUgZGVzY3JpcHRvciBpbnRvIHRoZSBkZXNjcmlwdG9yIEZJRk8gb2YgdGhlIERN
QSANCj4+Pj4gY29udHJvbGxlciwNCj4+Pj4gK8KgwqDCoMKgICogZXhjbHVkaW5nIHRoZSBjb250
cm9sIHdvcmQuIFRoZSBGSUZPIGlzIGZsdXNoZWQgYW5kIHRoZSANCj4+Pj4gZGVzY3JpcHRvcg0K
Pj4+PiArwqDCoMKgwqAgKiBiZWNvbWVzIHZhbGlkIG9uY2UgdGhlIGNvbnRyb2wgd29yZCBpcyB3
cml0dGVuIGxhc3QuDQo+Pj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4+PiAtwqDCoMKgIG1lbWNweSgo
dm9pZCBfX2ZvcmNlICopaHdfZGVzYywgJmRlc2MtPmh3X2Rlc2MsDQo+Pj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoCBzaXplb2YoZGVzYy0+aHdfZGVzYykgLSBzaXplb2YodTMyKSk7DQo+Pj4+ICvC
oMKgwqAgbWVtY3B5X3RvaW8oaHdfZGVzYywgJmRlc2MtPmh3X2Rlc2MsDQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG9mZnNldG9mKHN0cnVjdCBtc2dkbWFfZXh0ZW5kZWRfZGVzYywgY29u
dHJvbCkpOw0KPj4+DQo+Pj4gW1NldmVyaXR5OiBIaWdoXQ0KPj4+IFRoaXMgaXMgYSBwcmUtZXhp
c3RpbmcgaXNzdWUsIGJ1dCBkb2VzIG1lbWNweV90b2lvKCkgcHJvdmlkZSB0aGUgDQo+Pj4gc3Ry
aWN0bHkNCj4+PiBzZXF1ZW50aWFsIDMyLWJpdCBhY2Nlc3NlcyByZXF1aXJlZCBieSB0aGUgaGFy
ZHdhcmUgZmlmbz8NCj4+Pg0KPj4+IFNpbmNlIG1lbWNweV90b2lvKCkgaXMgYXJjaGl0ZWN0dXJl
LWRlcGVuZGVudCBhbmQgbWF5IGludGVybmFsbHkgdXNlIA0KPj4+IGJ5dGUNCj4+PiB3cml0ZXMs
IDY0LWJpdCB3cml0ZXMsIG9yIGNvcHkgaW4gYSBub24tc2VxdWVudGlhbCBvcmRlciwgd291bGQg
YW4gDQo+Pj4gZXhwbGljaXQNCj4+PiBsb29wIHVzaW5nIGEgY29uc2lzdGVudCAzMi1iaXQgYWNj
ZXNzb3IgbGlrZSB3cml0ZXNsKCkgZ3VhcmFudGVlIHRoZQ0KPj4+IHJlcXVpcmVkIGFjY2VzcyBw
YXR0ZXJuIGluc3RlYWQ/DQo+Pj4NCj4+PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+Pj4gVGhpcyBpcyBh
IHByZS1leGlzdGluZyBpc3N1ZSwgYnV0IGRvZXMgbWl4aW5nIG1lbWNweV90b2lvKCkgYW5kIA0K
Pj4+IGlvd3JpdGUzMigpDQo+Pj4gY2F1c2UgZGF0YSBjb3JydXB0aW9uIG9uIGJpZy1lbmRpYW4g
YXJjaGl0ZWN0dXJlcz8NCj4+Pg0KPj4+IFNpbmNlIG1lbWNweV90b2lvKCkgcHJlc2VydmVzIGhv
c3QgYnl0ZSBvcmRlciB3aGlsZSBpb3dyaXRlMzIoKSAoY2FsbGVkDQo+Pj4gc3Vic2VxdWVudGx5
IHRvIHdyaXRlIHRoZSBjb250cm9sIHdvcmQpIHBlcmZvcm1zIGNwdS10by1sZSBieXRlLSANCj4+
PiBzd2FwcGluZyBvbg0KPj4+IGJpZy1lbmRpYW4gc3lzdGVtcywgdGhlIGRlc2NyaXB0b3IgYm9k
eSB3aWxsIGJlIHdyaXR0ZW4gaW4gYmlnLWVuZGlhbiANCj4+PiBtZW1vcnkNCj4+PiBvcmRlciB3
aGlsZSB0aGUgY29udHJvbCB3b3JkIHdpbGwgYmUgc3dhcHBlZCB0byBsaXR0bGUtZW5kaWFuLg0K
Pj4+DQo+Pj4gRG9lcyB0aGlzIHJlcXVpcmUgYSBjb25zaXN0ZW50IHN0cmVhbS1vcmllbnRlZCBh
Y2Nlc3NvciBmYW1pbHkgZm9yIA0KPj4+IGJvdGggdGhlDQo+Pj4gYnVsayBjb3B5IGFuZCB0aGUg
cmVtYWluZGVyPw0KPj4+DQo+Pj4+IMKgwqDCoMKgwqAgLyogV3JpdGUgY29udHJvbCB3b3JkIGxh
c3QgdG8gZmx1c2ggdGhpcyBkZXNjcmlwdG9yIGludG8gdGhlIA0KPj4+PiBGSUZPICovDQo+Pj4+
IMKgwqDCoMKgwqAgbWRldi0+aWRsZSA9IGZhbHNlOw0KPj4+DQo+PiBUaGFua3MgZm9yIHRoZSBy
ZXZpZXcuDQo+Pg0KPj4gRHVwbGljYXRlIHN0YXRpY19hc3NlcnQ6IEFncmVlZCDigJQgY29weS1w
YXN0ZSBlcnJvciBpbiB2MjsgdjMga2VlcHMgYSANCj4+IHNpbmdsZSBzdGF0aWNfYXNzZXJ0IGJl
Zm9yZSBtZW1jcHlfdG9pbygpLg0KPj4NCj4+IFRoZSBGSUZPLWZ1bGwgbWRlbGF5KCkgbG9vcCwg
YWNjZXNzLXdpZHRoIHNlbWFudGljcywgYW5kIGJpZy1lbmRpYW4gDQo+PiBiZWhhdmlvciBhcmUg
cHJlLWV4aXN0aW5nIGFuZCB1bmNoYW5nZWQgYnkgdGhpcyBwYXRjaC4gVGhpcyBzZXJpZXMgDQo+
PiBvbmx5IHN3aXRjaGVzIHRoZSBkZXNjcmlwdG9yIGJvZHkgY29weSB0byBtZW1jcHlfdG9pbygp
IHBlciBGcmFua+KAmXMgDQo+PiBmZWVkYmFjaywga2VlcHMgdGhlIGNvbnRyb2wgd29yZCB3cml0
dGVuIGxhc3Qgd2l0aCBiYXJyaWVycywgYW5kIGFkZHMgDQo+PiBhIHN0YXRpY19hc3NlcnQgc28g
b2Zmc2V0b2YoY29udHJvbCkgcmVtYWlucyB2YWxpZC4gSSBjYW4gYWRkcmVzcyB0aGUgDQo+PiBG
SUZPIHBvbGxpbmcgYW5kIHN0cmljdGVyIE1NSU8gYWNjZXNzIGluIGEgc2VwYXJhdGUgcGF0Y2gg
aWYgDQo+PiBtYWludGFpbmVycyB3YW50IHRoYXQuDQo+Pg0KPj4gVGhhbmtzLA0KPj4gVHplIFll
ZQ0KPiANCj4gSGkgRnJhbmssDQo+IA0KPiBTYXNoaWtvIGZsYWdnZWQgbWVtY3B5X3RvaW8oKSB2
cyBhbiBleHBsaWNpdCBpb3dyaXRlMzIoKSBsb29wIGZvciB0aGUgDQo+IGRlc2NyaXB0b3IgRklG
Ty4gSeKAmWQgbGlrZSB0byBhbGlnbiB3aXRoIHlvdXIgZWFybGllciBmZWVkYmFjayDigJQgdXNl
cyANCj4gbWVtY3B5X3RvaW8oKSBmb3IgdGhlIGJvZHkgYW5kIGlvd3JpdGUzMigpIGxhc3QgZm9y
IGNvbnRyb2wsIHdpdGggYSANCj4gc2luZ2xlIHN0YXRpY19hc3NlcnQuDQo+IA0KPiBBcmUgeW91
IHN0aWxsIE9LIHdpdGggdGhhdCBmb3IgdGhpcyBzZXJpZXMsIG9yIHNob3VsZCB3ZSBtb3ZlIHRv
IGFuDQo+IGlvd3JpdGUzMigpIGxvb3AgZm9yIHRoZSB3aG9sZSBkZXNjcmlwdG9yPw0KPiANCj4g
VGhhbmtzLA0KPiBUemUgWWVlDQoNCkhpIEZyYW5rLA0KDQpGcmllbmRseSBmb2xsb3ctdXAgb24g
dGhlIHBhdGNoIGJlbG93IOKAlCBubyBydXNoLCBidXQgd2FudGVkIHRvIGNoZWNrIGlmDQp5b3Ug
aGFkIGEgY2hhbmNlIHRvIGxvb2sgYXQgdGhlIFNhc2hpa28ncyBjb21tZW50IG9uIG1lbWNweV90
b2lvKCk/DQoNCklmIHlvdSB3b3VsZCBwcmVmZXIgdXMgc3dpdGNoIHRvIGFuIGV4cGxpY2l0IGlv
d3JpdGUzMigpIGxvb3AsIEkgd2lsbCANCmZpeCBpdCBpbiB2MywgdG9nZXRoZXIgd2l0aCB0aGUg
ZHVwbGljYXRlIHN0YXRpY19hc3NlcnQgcHJvYmxlbSBmbGFnZ2VkIA0KYnkgU2FzaGlrby4NCg0K
VGhhbmtzLA0KVHplIFllZQ0KDQo=

