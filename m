Return-Path: <dmaengine+bounces-10987-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMELLDq2F2pvOAgAu9opvQ
	(envelope-from <dmaengine+bounces-10987-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 05:27:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A25EC33B
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 05:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9F03019BA5
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DA1F5858;
	Thu, 28 May 2026 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OhCWgfvK"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87342C3259
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938766; cv=fail; b=mgo26rkgA6ZbsrnxAhDf7qosLY8ZnhSmr9sbvqq9rNrOBAPAnxd0IErOYJ1GBOMpDZiCuDDbTnnjwDZIshT6uNTflxLJopGQiCTUUPl1wshseW/xen09+wZoHvAYkJvSTp2ZmEj+DpafSlYl+D3AKyu1npH1p7/94y2xUF+HUTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938766; c=relaxed/simple;
	bh=TkBZywmrKm93gohcSZ9GaUCXWvSV6Miwb3qVoW287Hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TP9fe3mNROlvkYeWa2Dl7CvtnJxejru6E51L5eqq4Hv2VAxRJzUUjwB70lYWPI6Sa9Dg+BxKHfSELtg1QKm3t9/wXsWsr6syMdgIy+n7ZILJPVKdfnhncq1TuxJquogSiIDA17BlUDLrYXRSphFRw6VYS2ubYJUl2caHd6nXNR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OhCWgfvK; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n79EjK8xbaFWww93yr1D6e4cdbv2OTCsNx6KX/UYA+oeM6U9dBbNE76ha8V1DQOzb2lUp1nrNeTmzXSM19IA/X4M9ss3y5PwCNuPQv0UVJ8HS5axKONt8cagaglIVK1LSFCCJThKPLtgstP/dw3lRTmYM07eldVGVFi9retNVwL7FJqwEcJsRnC7Q7VonHEajejZxT7zO3IfEUfcqF/M4pKYoeMmAfOvY+Ct9LHwlkSpdSvu3yKbaf+zSgZOFA8VvcPOtlsNzf0zlb0vHQwkGVKkIUYfm6AWDwL+Jetl/LaIBbV9+o+JG+EClTkN57lQXjzoD5ZEPkUP3Ode5FjIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkBZywmrKm93gohcSZ9GaUCXWvSV6Miwb3qVoW287Hc=;
 b=Btjt52+9F5XS85lR8KaFDQjwINC5cgR4xQEJ7V6lIgWbo6vEjZElRoDcczk9BQQpHDKfyzXGkolwUWkG+sl91iZ5Mld0Zt/qNnEqy9xGZypUEPNlWUaHAN/cr7PXUK3WO5XYNpB6iiRDx5KstlrY9RF274YpEyuNYxk35QCRHO4zquBtT0vz5UPEL/KCHGF493NKwDybGVD63RDDckZlp3yL9Iy/hWjOzW9YhE5IMAT6djhBPb5juAOzYWVmQjv0s60TKqncwTlZ9mGhIyYKxaRqjPbke7KPU4fH++pzEkbLMH3i0uuj67aJA3hAY+RPKFfdSIUUk4Pw1cDzUQcjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkBZywmrKm93gohcSZ9GaUCXWvSV6Miwb3qVoW287Hc=;
 b=OhCWgfvKcm3QQtu8fnUj5+lG691UZD3Y76k6yr7FD5buSkDFVUO/MNZAYBzYyrwr6m9zm2323kBJa3VX0Wvr0ZxbB+2FKcYShOdZgQz/badCkcHSzPHQppjxTccXJR7ErqYKK9ZuYk6G1xwbc+ui/9De4woi92R9NYAVRr70tBPGaD8B7Qtio50RAd3p4zyAv/9uzYNUNg4XUaQApdq9n79HMdRnvTj6JSS8QLmk+CpCInSSHScIy0ykv+HljluzJ3JgdG5dhRY9QYU4FQTnWa0mOA3h4MqcAeVkLmUnnhMlbW3MHvjaGxKTshG118xRDfnI7dQcgEMT0ke+eXK1Wg==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by BY1PR03MB7240.namprd03.prod.outlook.com (2603:10b6:a03:52b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 03:26:01 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 03:26:01 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, Olivier Dautricourt
	<olivierdautricourt@gmail.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor
 FIFO writes
Thread-Topic: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor
 FIFO writes
Thread-Index: AQHc7CG60nndVcDxp0WjWCcKmwC0WrYeb48AgAASO4CABElbAA==
Date: Thu, 28 May 2026 03:26:01 +0000
Message-ID: <79e200dd-6071-4443-90a7-db915175100a@altera.com>
References:
 <f6f3b4a2e2eb0eb1a51976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com>
 <20260525085311.1C2341F000E9@smtp.kernel.org>
 <621a83f5-140e-4947-ba9a-5eeef8b4148a@altera.com>
In-Reply-To: <621a83f5-140e-4947-ba9a-5eeef8b4148a@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|BY1PR03MB7240:EE_
x-ms-office365-filtering-correlation-id: 778f3c38-7bae-476e-a02b-08debc68d77b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|38070700021|4143699003|56012099006|6133799003|3023799007|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 3lDuV/rr3b59b/iysB7WJ0dtdGRY7WX5MvADCqJYpfso/a/aRzn4uh340x/aD2uxz6++32MvIKyNEP93sbYsC5rnBwZknfHLvpD/73vjWBYQAtQJLKYnZIBvY0AR6OSt4eMjCicR9XcVwn3ayhMyA7NWa6OdfcI5fFephvuxUZtybvfB2pqJauUVi+1ZpaM6ZYrCpg0P5T7CxGjXaaZykYlccB12pAYENEZo06nMtaI2xFz6xi/1GKtjN8xzWk8jBXD97uZj5KOYQmnh0LmoNKJKEYJRBNG2medjLrgc1VYcUMPtrRq6YCuZWbxPMWkjZz1uieP3UjTbVWz4DUSmzCZCa8Tll2LPXji466rkVva21DRMi+ugNi6TE7zK5GI7B0zWJyxnOdeHD/K+x3RT5pOienbC4KauiwjiVmOICuBlKSoV7ChlQyN8uEj64V4DOZT6lF4txsFVn+TzWWMmJabMGNbGaVVIO4E5b9XsoWxqoxgCPGle5amqvrM06DreP8mXmsBLdlaoPcaxNrmaTGUqa5cbR2iY1qzevzZiX7FMTogmc53yUUVXhiBtYA/mEzPaoQyBCEPQ8j82QWRjVuzL9LjtMILpyGBTKQ9d/DiUP1kBqoljBi1XJecRnoneTsfQgjDmso8flgfgNSHusrXI/hC59KsrU8yhi6WgntFFS+AVViXn8vPDcIfpXmrYy3VUOsl6FMsuNdjrAJWmJMNp0AQ/PikXq9EFJrMHjnCy4PrivDlwYi0XVc0zvsi0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(38070700021)(4143699003)(56012099006)(6133799003)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1pMK0JMTkRtQlpSUmR4UHNEOUlVTXlmeURWKzZVZHNLaEtiZ2VKajhidmpV?=
 =?utf-8?B?VWh1VnBhdFByQzBCdFp5R0kzVFZYdUVueFZSSktXbEZhREkraWRuRnhrbCs0?=
 =?utf-8?B?REhYVlVYbk1pQVRoWU0reXRUNDBGV3AxWWRhRk5uN3NqTlVLZmdmT01TajJD?=
 =?utf-8?B?dVM1WTRTelNPZGk2UTRvUStFenlvZlZsQWpQbkZyVHRqVDBMUk16dWc0VVlN?=
 =?utf-8?B?dkNrWUZ5M0hlOEdwaEtkNTZYYmVVUWNiakNzVThQOFl1ejJzN0JRTEt0cHd2?=
 =?utf-8?B?aXl1TGo4V3RoemhjWk9SaERkdnpqcXZ4cCtjdy82bFoyY2tjeW1XRFF5Tkk0?=
 =?utf-8?B?Vko1dVdqcGJEUEMvR3hsVUxMMm9xUmtLWHk3clNhdWVMZEphRytLSGlBeGd4?=
 =?utf-8?B?dlJUQUd1VnBPT1MrVnk5NzVBanNQN202cUUrWlVNZnZBV0tBSUxXcXV5NHY4?=
 =?utf-8?B?cEV6dzRPbUNMMFdiRVdzV1F5cURVR0NJdFB2R3FPcGFvaTBFeWZnUTRFL0Iv?=
 =?utf-8?B?UDEvLzhHT0NuU0F6ZEJGRHpMb1U0dk9CUytCeTNzUDFoVmJaa0dlRnpFNkk5?=
 =?utf-8?B?MWJXelUvQUJZRm9BQVlvUk10bDJnaXNqZmdEbjRRakFybVVISEhsL2NTN0hW?=
 =?utf-8?B?T3FSUm83R0llZHYzaWxjVUNGeHB5OEZJbUkxamNZMVV2MGZiSWx5SEN5K1R1?=
 =?utf-8?B?V0EyVER0L0Roc2ZLL2Rjei9ETERvZDNYemZVbXM4c25wLzJRcXgyYkNxaTNp?=
 =?utf-8?B?SUczVkFNbE0xR29LOWZ0N1MvTDhoMHRteGtUeW5qbWpiYnFiMEJPcGtVNWFB?=
 =?utf-8?B?NlpSVDd3VHhQQ1B0empsSndNUEl0WHdtODRnS3FqOGNMbE5FbHJlcGlHS0hQ?=
 =?utf-8?B?WXJTRUhVdGZmTXRKdkE4Z3FmS09QOVNjQUNsemNQY2JMelkwMUtwT1Z1SGNZ?=
 =?utf-8?B?ODhvcmZZMVZvWDdiL0EyTXNsMk9LckJXVlZWMXZWSk5hcnhIWGQyczFOa0Z1?=
 =?utf-8?B?N09ic0sva0htYys4VFl2NXVLSjhHa21tTXAvc29YVFlUekUrMTF2eFc3L2E1?=
 =?utf-8?B?WUVBNis1bldCQ3g0NllPTnNDYVBKWmxtejlLR1hMdHRiUTJrOGRoVG5mWE8r?=
 =?utf-8?B?L29iTlVqSnl2bjdXOEUvUERybE9BMjh1MW42dWE0aTd4aE42dDg3RmJqWGQ4?=
 =?utf-8?B?d1Z1SktpcnUvQkFqUThoRmZqVVI1ODVWL3YxekR2NW4vVG00cVZIdkJ4WlIv?=
 =?utf-8?B?aWdFZGlQUXZhenFTaVJ1d2J1QzFVQ21MYjNNRGxJNGlmU0FsZEZDdzFNQVMw?=
 =?utf-8?B?SXpMUzBxY2JjQ0FDeE1Oa3hlbFZyQ2taazlsMnU5U1lscVEraEltWmRRUWRs?=
 =?utf-8?B?Wm5yWVFCQWdtTTY4WjAvWERGS0VOamxudVRBTTd4NGN1aFNNWjlSdzBGaTBy?=
 =?utf-8?B?dXNxZXFpYjlBblEzVEVYQ1NYTGsvUDZZMUxYOFdiOFo1N1BQdnllY21qbXox?=
 =?utf-8?B?TWRnaVFwazd6SjFLd0haaHhPWGt3K0doSnZyMVN1SmZZWDdjZjNpcm1YRmhN?=
 =?utf-8?B?czk4bHYyVXBNSUxFMVhjblRmMDY3MXRYcWE0UlZCbnRGZ1ViRHVSaEdwVEZn?=
 =?utf-8?B?Tzd6c25ZYkp6VENFa2g4Y2tiaTYyOFJmV1lCMW9hWEF2bXRlS2Z0aHRrNmJD?=
 =?utf-8?B?bVNDSkxNSk1DRXFabyt5ZWNLZDFaVkM1Zi9ta1hkNjB3a05icEJGcFhDZUN4?=
 =?utf-8?B?NTJxQ1BuUHVJL3BLL0ExM20vK2kzL0tHTE9EeXRxdy80Y3dSMTVqZjFsMmZx?=
 =?utf-8?B?eFhTWTVZekYvNHVqR0ovelVvaFFmam5pcm9kL0twWVp4VGNXTHUzaXdKVllw?=
 =?utf-8?B?ekk3SVpTcjFuMDBMNlJ1RndFMlBobnBaYUUyRFNqdVFKcG1aVy9sNUZVdU02?=
 =?utf-8?B?dFYxNFNPc3dYcnZ5cnEweGRFT2VGTy9XdU43ZkpaNDJockhXVk1zdldLZ1N4?=
 =?utf-8?B?S2NVSHluWWh3VXlzWW9RZlEvVU1hTGVaTUJGL25uQzVCbTNTdzNtWFpoODBx?=
 =?utf-8?B?TmpUTVh2VXJpcGIxbS96RE8rS3hyOHdyaWxpeWpMSWVJa3RITk1FRFNEL0N2?=
 =?utf-8?B?SEZiVWFzRXdKVUZ0cVF2WW1wOW1iN2N6Umc0aElpUE01SCtaUmRaNGZnbHVo?=
 =?utf-8?B?dUo4Uzc0TWRFaWdwVlJIYVJtUThqeS84K0J5UitnbiszTk5ObWlYOVBibmVY?=
 =?utf-8?B?aVZqQkRYb3F0ZE1CNHFlbFhnK1N0NnRIWm9BZVZiVmFWajJkbHp2QktzVmdr?=
 =?utf-8?B?bHFYTzdwU1Z0S21HbmRmb0hjQXpmSUR2dmkwdnBwQWw5WE82Y2JLT3ovd005?=
 =?utf-8?Q?q2TYlsWze40ze7RM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <171B724703604C46A19D3A2F144BCFEA@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 778f3c38-7bae-476e-a02b-08debc68d77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 03:26:01.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dd8oq47QwJyKBc8fN6IJVXHbQHZGBLjKhJSd1jQ1ohHeQbNDEEH86lHWIqdhXwrw/nV2Nj6tgKErUq/f5t8jyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7240
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10987-lists,dmaengine=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:email,altera.com:mid,altera.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E4A25EC33B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMjUvNS8yMDI2IDU6NTggcG0sIE5HLCBUWkUgWUVFIHdyb3RlOg0KPiBPbiAyNS81LzIwMjYg
NDo1MyBwbSwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4+IFRoYW5rIHlvdSBmb3Ig
eW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDQgcG90ZW50aWFsIA0K
Pj4gaXNzdWUocykgdG8gY29uc2lkZXI6DQo+Pg0KPj4gTmV3IGlzc3VlczoNCj4+IC0gW0xvd10g
VGhlIHBhdGNoIGluYWR2ZXJ0ZW50bHkgZHVwbGljYXRlcyB0aGUgYHN0YXRpY19hc3NlcnRgIGJs
b2NrIA0KPj4gZm9yIHRoZSBjb250cm9sIGZpZWxkIG9mZnNldC4NCj4+DQo+PiBQcmUtZXhpc3Rp
bmcgaXNzdWVzOg0KPj4gLSBbSGlnaF0gTWl4ZWQgdXNhZ2Ugb2YgYG1lbWNweV90b2lvKClgIGFu
ZCBgaW93cml0ZTMyKClgIHdoZW4gd3JpdGluZyANCj4+IHRvIHRoZSBkZXNjcmlwdG9yIE1NSU8g
RklGTyByZXN1bHRzIGluIGluY29uc2lzdGVudCBlbmRpYW5uZXNzIA0KPj4gYmVoYXZpb3Igb24g
YmlnLWVuZGlhbiBhcmNoaXRlY3R1cmVzLg0KPj4gLSBbSGlnaF0gYG1lbWNweV90b2lvKClgIGRv
ZXMgbm90IGd1YXJhbnRlZSB0aGUgc3RyaWN0bHkgc2VxdWVudGlhbCANCj4+IDMyLWJpdCBhY2Nl
c3NlcyByZXF1aXJlZCBieSB0aGUgaGFyZHdhcmUgZGVzY3JpcHRvciBGSUZPLg0KPj4gLSBbSGln
aF0gVGhlIGRyaXZlciBwb2xscyB0aGUgZGVzY3JpcHRvciBidWZmZXIgc3RhdHVzIGluZGVmaW5p
dGVseSANCj4+IHVzaW5nIGBtZGVsYXkoKWAsIHdoaWNoIGNhbiBoYW5nIHRoZSBzeXN0ZW0gaWYg
dGhlIGhhcmR3YXJlIHN0YWxscy4NCj4+IC0tIA0KPj4NCj4+IGNvbW1pdCAwNzc0ODhmZTVjYmEw
YTdmMGM4NDEwZDY5ZTVjYjBmNjg4ZTY1NDg1DQo+PiBBdXRob3I6IEFkcmlhbiBOZyBIbyBZaW4g
PGFkcmlhbmhveWluLm5nQGFsdGVyYS5jb20+DQo+Pg0KPj4gZG1hOiBhbHRlcmEtbXNnZG1hOiBV
c2UgbWVtY3B5X3RvaW8gZm9yIGRlc2NyaXB0b3IgRklGTyB3cml0ZXMNCj4+DQo+PiBUaGlzIGNv
bW1pdCByZXBsYWNlcyB0aGUgZm9yY2VkIF9faW9tZW0gbWVtY3B5KCkgd2l0aCBtZW1jcHlfdG9p
bygpIGZvcg0KPj4gY29weWluZyBkZXNjcmlwdG9yIGJvZGllcyB0byB0aGUgZG1hIGVuZ2luZSBm
aWZvLiBJdCBhbHNvIGludHJvZHVjZXMgYQ0KPj4gc3RhdGljX2Fzc2VydCB0byBlbnN1cmUgdGhl
IGNvbnRyb2wgd29yZCBpcyB0aGUgbGFzdCBmaWVsZCBpbiB0aGUgc3RydWN0LA0KPj4gYXMgd3Jp
dGluZyB0aGUgY29udHJvbCB3b3JkIGZsdXNoZXMgdGhlIGZpZm8uDQo+Pg0KPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2RtYS9hbHRlcmEtbXNnZG1hLmMgYi9kcml2ZXJzL2RtYS9hbHRlcmEtbXNn
ZG1hLmMNCj4+PiBpbmRleCBiNDY5OTljODFkZjAwLi5lMjNlNWI0NDFhMjRlIDEwMDY0NA0KPj4+
IC0tLSBhL2RyaXZlcnMvZG1hL2FsdGVyYS1tc2dkbWEuYw0KPj4+ICsrKyBiL2RyaXZlcnMvZG1h
L2FsdGVyYS1tc2dkbWEuYw0KPj4+IEBAIC00OTYsNiArNDk2LDExIEBAIHN0YXRpYyB2b2lkIG1z
Z2RtYV9jb3B5X29uZShzdHJ1Y3QgbXNnZG1hX2RldmljZSANCj4+PiAqbWRldiwNCj4+PiDCoCB7
DQo+Pj4gwqDCoMKgwqDCoCB2b2lkIF9faW9tZW0gKmh3X2Rlc2MgPSBtZGV2LT5kZXNjOw0KPj4+
ICvCoMKgwqAgLyogRW5zdXJlIGNvbnRyb2wgaXMgdGhlIGxhc3QgZmllbGQg4oCUIHJlcXVpcmVk
IGZvciBjb3JyZWN0IEZJRk8gDQo+Pj4gZmx1c2ggb3JkZXJpbmcgKi8NCj4+PiArwqDCoMKgIHN0
YXRpY19hc3NlcnQob2Zmc2V0b2Yoc3RydWN0IG1zZ2RtYV9leHRlbmRlZF9kZXNjLCBjb250cm9s
KSA9PQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2Yoc3RydWN0IG1zZ2Rt
YV9leHRlbmRlZF9kZXNjKSAtIHNpemVvZih1MzIpLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiY29udHJvbCBtdXN0IGJlIHRoZSBsYXN0IGZpZWxkIGluIA0KPj4+IG1zZ2RtYV9l
eHRlbmRlZF9kZXNjIik7DQo+Pj4gKw0KPj4+IMKgwqDCoMKgwqAgLyoNCj4+PiDCoMKgwqDCoMKg
wqAgKiBDaGVjayBpZiB0aGUgREVTQyBGSUZPIGl0IG5vdCBmdWxsLiBJZiBpdHMgZnVsbCwgd2Ug
bmVlZCB0byANCj4+PiB3YWl0DQo+Pj4gwqDCoMKgwqDCoMKgICogZm9yIGF0IGxlYXN0IG9uZSBl
bnRyeSB0byBiZWNvbWUgZnJlZSBhZ2Fpbg0KPj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4+IMKgwqDC
oMKgwqAgd2hpbGUgKGlvcmVhZDMyKG1kZXYtPmNzciArIE1TR0RNQV9DU1JfU1RBVFVTKSAmDQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1TR0RNQV9DU1JfU1RBVF9ERVNDX0JVRl9GVUxM
KQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtZGVsYXkoMSk7DQo+Pg0KPj4gW1NldmVyaXR5OiBI
aWdoXQ0KPj4gVGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1ZSwgYnV0IGRvZXMgdGhpcyBsb29w
IHJpc2sgYSBoYXJkIGtlcm5lbCANCj4+IGxvY2t1cD8NCj4+DQo+PiBTaW5jZSB0aGlzIGZ1bmN0
aW9uIGV4ZWN1dGVzIHdoaWxlIGhvbGRpbmcgYSBzcGlubG9jayBkdXJpbmcgdGhlIGlycSANCj4+
IGhhbmRsZXI6DQo+Pg0KPj4gbXNnZG1hX2lycV9oYW5kbGVyKCktPm1zZ2RtYV9zdGFydF90cmFu
c2ZlcigpLT5tc2dkbWFfY29weV9vbmUoKQ0KPj4NCj4+IHBvbGxpbmcgaW5kZWZpbml0ZWx5IHdp
dGggbWRlbGF5KCkgd2l0aG91dCBhIHRpbWVvdXQgY291bGQgd2VkZ2UgdGhlIGNwdQ0KPj4gaWYg
dGhlIGhhcmR3YXJlIGZhaWxzIHRvIGRyYWluIHRoZSBkZXNjcmlwdG9yIGZpZm8uIFNob3VsZCB0
aGlzIHVzZSBhDQo+PiBwcm9wZXIgdGltZW91dCBsb29wIGxpa2UgcmVhZGxfcG9sbF90aW1lb3V0
X2F0b21pYygpIGluc3RlYWQ/DQo+Pg0KPj4+ICvCoMKgwqAgLyogRW5zdXJlIGNvbnRyb2wgaXMg
dGhlIGxhc3QgZmllbGQg4oCUIHJlcXVpcmVkIGZvciBjb3JyZWN0IEZJRk8gDQo+Pj4gZmx1c2gg
b3JkZXJpbmcgKi8NCj4+PiArwqDCoMKgIHN0YXRpY19hc3NlcnQob2Zmc2V0b2Yoc3RydWN0IG1z
Z2RtYV9leHRlbmRlZF9kZXNjLCBjb250cm9sKSA9PQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNpemVvZihzdHJ1Y3QgbXNnZG1hX2V4dGVuZGVkX2Rlc2MpIC0gc2l6ZW9mKHUzMiksDQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImNvbnRyb2wgbXVzdCBiZSB0aGUgbGFzdCBmaWVs
ZCBpbiBtc2dkbWFfZXh0ZW5kZWRfZGVzYyIpOw0KPj4+ICsNCj4+DQo+PiBbU2V2ZXJpdHk6IExv
d10NCj4+IElzIHRoaXMgcmVncmVzc2lvbiBhIGNvcHktcGFzdGUgZXJyb3I/IFRoZSBleGFjdCBz
YW1lIHN0YXRpY19hc3NlcnQgYW5kDQo+PiBjb21tZW50IHdlcmUgYWxzbyBhZGRlZCBqdXN0IGJl
Zm9yZSB0aGUgd2hpbGUgbG9vcCBpbiB0aGlzIHBhdGNoLg0KPj4NCj4+PiDCoMKgwqDCoMKgIC8q
DQo+Pj4gLcKgwqDCoMKgICogVGhlIGRlc2NyaXB0b3IgbmVlZHMgdG8gZ2V0IGNvcGllZCBpbnRv
IHRoZSBkZXNjcmlwdG9yIEZJRk8NCj4+PiAtwqDCoMKgwqAgKiBvZiB0aGUgRE1BIGNvbnRyb2xs
ZXIuIFRoZSBkZXNjcmlwdG9yIHdpbGwgZ2V0IGZsdXNoZWQgdG8gdGhlDQo+Pj4gLcKgwqDCoMKg
ICogRklGTywgb25jZSB0aGUgbGFzdCB3b3JkIChjb250cm9sIHdvcmQpIGlzIHdyaXR0ZW4uIFNp
bmNlIHdlDQo+Pj4gLcKgwqDCoMKgICogYXJlIG5vdCAxMDAlIHN1cmUgdGhhdCBtZW1jcHkoKSB3
cml0ZXMgYWxsIHdvcmQgaW4gdGhlICJjb3JyZWN0Ig0KPj4+IC3CoMKgwqDCoCAqIG9yZGVyIChh
ZGRyZXNzIGZyb20gbG93IHRvIGhpZ2gpIG9uIGFsbCBhcmNoaXRlY3R1cmVzLCB3ZSBtYWtlDQo+
Pj4gLcKgwqDCoMKgICogc3VyZSB0aGlzIGNvbnRyb2wgd29yZCBpcyB3cml0dGVuIGxhc3QgYnkg
c2luZ2xlIGNvZGluZyBpdCBhbmQNCj4+PiAtwqDCoMKgwqAgKiBhZGRpbmcgc29tZSB3cml0ZS1i
YXJyaWVycyBoZXJlLg0KPj4+ICvCoMKgwqDCoCAqIENvcHkgdGhlIGRlc2NyaXB0b3IgaW50byB0
aGUgZGVzY3JpcHRvciBGSUZPIG9mIHRoZSBETUEgDQo+Pj4gY29udHJvbGxlciwNCj4+PiArwqDC
oMKgwqAgKiBleGNsdWRpbmcgdGhlIGNvbnRyb2wgd29yZC4gVGhlIEZJRk8gaXMgZmx1c2hlZCBh
bmQgdGhlIA0KPj4+IGRlc2NyaXB0b3INCj4+PiArwqDCoMKgwqAgKiBiZWNvbWVzIHZhbGlkIG9u
Y2UgdGhlIGNvbnRyb2wgd29yZCBpcyB3cml0dGVuIGxhc3QuDQo+Pj4gwqDCoMKgwqDCoMKgICov
DQo+Pj4gLcKgwqDCoCBtZW1jcHkoKHZvaWQgX19mb3JjZSAqKWh3X2Rlc2MsICZkZXNjLT5od19k
ZXNjLA0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoZGVzYy0+aHdfZGVzYykgLSBz
aXplb2YodTMyKSk7DQo+Pj4gK8KgwqDCoCBtZW1jcHlfdG9pbyhod19kZXNjLCAmZGVzYy0+aHdf
ZGVzYywNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZzZXRvZihzdHJ1Y3QgbXNnZG1h
X2V4dGVuZGVkX2Rlc2MsIGNvbnRyb2wpKTsNCj4+DQo+PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+PiBU
aGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBidXQgZG9lcyBtZW1jcHlfdG9pbygpIHByb3Zp
ZGUgdGhlIHN0cmljdGx5DQo+PiBzZXF1ZW50aWFsIDMyLWJpdCBhY2Nlc3NlcyByZXF1aXJlZCBi
eSB0aGUgaGFyZHdhcmUgZmlmbz8NCj4+DQo+PiBTaW5jZSBtZW1jcHlfdG9pbygpIGlzIGFyY2hp
dGVjdHVyZS1kZXBlbmRlbnQgYW5kIG1heSBpbnRlcm5hbGx5IHVzZSBieXRlDQo+PiB3cml0ZXMs
IDY0LWJpdCB3cml0ZXMsIG9yIGNvcHkgaW4gYSBub24tc2VxdWVudGlhbCBvcmRlciwgd291bGQg
YW4gDQo+PiBleHBsaWNpdA0KPj4gbG9vcCB1c2luZyBhIGNvbnNpc3RlbnQgMzItYml0IGFjY2Vz
c29yIGxpa2Ugd3JpdGVzbCgpIGd1YXJhbnRlZSB0aGUNCj4+IHJlcXVpcmVkIGFjY2VzcyBwYXR0
ZXJuIGluc3RlYWQ/DQo+Pg0KPj4gW1NldmVyaXR5OiBIaWdoXQ0KPj4gVGhpcyBpcyBhIHByZS1l
eGlzdGluZyBpc3N1ZSwgYnV0IGRvZXMgbWl4aW5nIG1lbWNweV90b2lvKCkgYW5kIA0KPj4gaW93
cml0ZTMyKCkNCj4+IGNhdXNlIGRhdGEgY29ycnVwdGlvbiBvbiBiaWctZW5kaWFuIGFyY2hpdGVj
dHVyZXM/DQo+Pg0KPj4gU2luY2UgbWVtY3B5X3RvaW8oKSBwcmVzZXJ2ZXMgaG9zdCBieXRlIG9y
ZGVyIHdoaWxlIGlvd3JpdGUzMigpIChjYWxsZWQNCj4+IHN1YnNlcXVlbnRseSB0byB3cml0ZSB0
aGUgY29udHJvbCB3b3JkKSBwZXJmb3JtcyBjcHUtdG8tbGUgYnl0ZS0gDQo+PiBzd2FwcGluZyBv
bg0KPj4gYmlnLWVuZGlhbiBzeXN0ZW1zLCB0aGUgZGVzY3JpcHRvciBib2R5IHdpbGwgYmUgd3Jp
dHRlbiBpbiBiaWctZW5kaWFuIA0KPj4gbWVtb3J5DQo+PiBvcmRlciB3aGlsZSB0aGUgY29udHJv
bCB3b3JkIHdpbGwgYmUgc3dhcHBlZCB0byBsaXR0bGUtZW5kaWFuLg0KPj4NCj4+IERvZXMgdGhp
cyByZXF1aXJlIGEgY29uc2lzdGVudCBzdHJlYW0tb3JpZW50ZWQgYWNjZXNzb3IgZmFtaWx5IGZv
ciANCj4+IGJvdGggdGhlDQo+PiBidWxrIGNvcHkgYW5kIHRoZSByZW1haW5kZXI/DQo+Pg0KPj4+
IMKgwqDCoMKgwqAgLyogV3JpdGUgY29udHJvbCB3b3JkIGxhc3QgdG8gZmx1c2ggdGhpcyBkZXNj
cmlwdG9yIGludG8gdGhlIA0KPj4+IEZJRk8gKi8NCj4+PiDCoMKgwqDCoMKgIG1kZXYtPmlkbGUg
PSBmYWxzZTsNCj4+DQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4NCj4gDQo+IER1cGxpY2F0ZSBz
dGF0aWNfYXNzZXJ0OiBBZ3JlZWQg4oCUIGNvcHktcGFzdGUgZXJyb3IgaW4gdjI7IHYzIGtlZXBz
IGEgDQo+IHNpbmdsZSBzdGF0aWNfYXNzZXJ0IGJlZm9yZSBtZW1jcHlfdG9pbygpLg0KPiANCj4g
VGhlIEZJRk8tZnVsbCBtZGVsYXkoKSBsb29wLCBhY2Nlc3Mtd2lkdGggc2VtYW50aWNzLCBhbmQg
YmlnLWVuZGlhbiANCj4gYmVoYXZpb3IgYXJlIHByZS1leGlzdGluZyBhbmQgdW5jaGFuZ2VkIGJ5
IHRoaXMgcGF0Y2guIFRoaXMgc2VyaWVzIG9ubHkgDQo+IHN3aXRjaGVzIHRoZSBkZXNjcmlwdG9y
IGJvZHkgY29weSB0byBtZW1jcHlfdG9pbygpIHBlciBGcmFua+KAmXMgZmVlZGJhY2ssIA0KPiBr
ZWVwcyB0aGUgY29udHJvbCB3b3JkIHdyaXR0ZW4gbGFzdCB3aXRoIGJhcnJpZXJzLCBhbmQgYWRk
cyBhIA0KPiBzdGF0aWNfYXNzZXJ0IHNvIG9mZnNldG9mKGNvbnRyb2wpIHJlbWFpbnMgdmFsaWQu
IEkgY2FuIGFkZHJlc3MgdGhlIEZJRk8gDQo+IHBvbGxpbmcgYW5kIHN0cmljdGVyIE1NSU8gYWNj
ZXNzIGluIGEgc2VwYXJhdGUgcGF0Y2ggaWYgbWFpbnRhaW5lcnMgd2FudCANCj4gdGhhdC4NCj4g
DQo+IFRoYW5rcywNCj4gVHplIFllZQ0KDQpIaSBGcmFuaywNCg0KU2FzaGlrbyBmbGFnZ2VkIG1l
bWNweV90b2lvKCkgdnMgYW4gZXhwbGljaXQgaW93cml0ZTMyKCkgbG9vcCBmb3IgdGhlIA0KZGVz
Y3JpcHRvciBGSUZPLiBJ4oCZZCBsaWtlIHRvIGFsaWduIHdpdGggeW91ciBlYXJsaWVyIGZlZWRi
YWNrIOKAlCB1c2VzIA0KbWVtY3B5X3RvaW8oKSBmb3IgdGhlIGJvZHkgYW5kIGlvd3JpdGUzMigp
IGxhc3QgZm9yIGNvbnRyb2wsIHdpdGggYSANCnNpbmdsZSBzdGF0aWNfYXNzZXJ0Lg0KDQpBcmUg
eW91IHN0aWxsIE9LIHdpdGggdGhhdCBmb3IgdGhpcyBzZXJpZXMsIG9yIHNob3VsZCB3ZSBtb3Zl
IHRvIGFuDQppb3dyaXRlMzIoKSBsb29wIGZvciB0aGUgd2hvbGUgZGVzY3JpcHRvcj8NCg0KVGhh
bmtzLA0KVHplIFllZQ0K

