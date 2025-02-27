Return-Path: <dmaengine+bounces-4592-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E2A4879D
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 19:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03A3168BD0
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7F81B6D1C;
	Thu, 27 Feb 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="AssaJ2BI"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010016.outbound.protection.outlook.com [52.101.228.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEC221A453;
	Thu, 27 Feb 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680193; cv=fail; b=aOF9LzOl1LGhYH9kLEt7NmVXE93CacekaHhInDUxX5dtR95zXRefBdMUeoWliEEQfgAFOGezlUuuAc8MWqrz6HEA9UTyvJXl00/mWUnzJOFJHyquLwM4TYBOFetwZOXDfSGZhFbEiaeFUPzSOlsyoD8HqxeJipuMQr4liLFXYgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680193; c=relaxed/simple;
	bh=tC6tswbum6XXRHVC+1VLkwElF+5em5t3e4QiJU4y/E8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JxOKoaY219+SeGzkSs7zINlMogDZYO6hSnJyOGdLwZbvYUZakw8SozHF7XW5pY0+2a1u9n+m7j39oJTASN5XkZVtCvq/GCM6I5T8Ot4dcvt25ucVRAimQC3fhBBz5o5Nla6TmrCj7k0jWd79vXA6m9dLZgFSUBo/c2qrLXUQOPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=AssaJ2BI; arc=fail smtp.client-ip=52.101.228.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQKzkixlwNzdWOlOo+0rad7689g/bxTtXsT6DU/khbFRAHKlYsp4R5Kcdmb0V0cIR7a80gREdwwivrqqZyvM/5KtqFlYTqIh8QcXAYV+xna3Vek9T3jy7dMDrlcxWoMug/8H44X2ykPxs1Qpjzcwu4Rmdw/GmP1sB0MGi/U0WVbSTdPFv4bTnflqfiqmdDNLWG3c0wwj5wJlIpVslWSszdBliJriI1BwvJ7VbyWZC8ZoZqAPSijQQLwQLsiO8TdoX79/O+wPiowKI8Ttsv2ZwQnIMGGdTB6ONF3KnMZvyiXI7mcqVojRHCW/u4c3chtV7MK+VgnvB/t+xN/pCOvFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC6tswbum6XXRHVC+1VLkwElF+5em5t3e4QiJU4y/E8=;
 b=EZREbYw70kng/z9RAv1RP03C0R/0baMRU+h8PNYHVU2O5NeaGLR5yiawMVWXh73nHlx7xUD+2G7h5INp0HRInQZUQ0bBVocroVK6OHuUmY+dtVjnJ6RPyCAvFzH4WLP+OWCNnuAi8x/2iUtZdFhqYaqStOLtKle+f3WtnPAm+/JwM9Ri+E7kgra8Q1HrnLgK1MugS+jbUmY0CuLb5HiW+Zd/nd+RWzQbp2kL98MUdN7gAbk58FSQsgKeyqOcsZOs7nnBx5jl/MKnrW5E99xENDMjGyV8V6a29DxzXEJIIAjsAg0A2Xv7lyahvuE/UxhHUqpSuiUOVkTxUz+GjmDDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC6tswbum6XXRHVC+1VLkwElF+5em5t3e4QiJU4y/E8=;
 b=AssaJ2BIJeOlV23Wzcd6ittr4SoIGXy1PJjoOqPSQX7exWLe1aBP0HqaVtTtkWUL4X9vb3Di/oK76kQTkSNm0RZKqVn9N8dhP+6GOZwDqkf6GCdHg9SEnnOZIHDE5bdY9ns7HJn8MTb63B3eQAm1GTr6SowFKnpi+jjiDJmOPRA=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OS3PR01MB7141.jpnprd01.prod.outlook.com (2603:1096:604:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 18:16:27 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:16:27 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Topic: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Index: AQHbg6hTr6k5RmdmC0qfs3vIpDif/7NWbDgAgAUL6qA=
Date: Thu, 27 Feb 2025 18:16:27 +0000
Message-ID:
 <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OS3PR01MB7141:EE_
x-ms-office365-filtering-correlation-id: 5776d0fc-ac79-490f-d0c2-08dd575ada37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFh3MXFLdEc0cVhQVVVpVE9WMkQ0Y0ZpZUl5Rks3YmJjNStYRFg5OVJEWkxC?=
 =?utf-8?B?ak1vUCt4QmNQM1dRb3UzN0JUMzlkUzFkUUhiOVZYTVFnUnRLSENyQXhRU0cw?=
 =?utf-8?B?dTR0RlliSWM5MXh2WVpFUm5Rbkc2aGN2TmJWQi9FZHJoeTZ3Y0Q4ZWZlQ2J6?=
 =?utf-8?B?MTdTbWYwNHk4SjU3dFozdm1TdnJ4QnJVbFB4V2x0djBrTm8zc3FVZ2NFMVdT?=
 =?utf-8?B?Wjh3WllwY3ZuZGI4QjZhR05jcXYzY3J5NnpwQ3YydnJWVEVrVm1MbHpPMmN4?=
 =?utf-8?B?V1ExOFdYZElGS2Y2a1EybXU2U1hnbmNCck9WWTVzSUF2aEpoR013NzdvN2Mv?=
 =?utf-8?B?ZXh5cDFLMXRzNEE4YWVBNWxpWkVhakRkOE9ocmVDNlJjQmFQcjBaQkMvRlcx?=
 =?utf-8?B?c21YeHBZV0FuS0cwMlFTeisyZ250aUZDNTR5VkVNb3kxcGFlcXpqbUJCWWVt?=
 =?utf-8?B?bFY2RUI5ejV1UWxFS1crZlRhZmFkUW9iRm54cVFCb2p0TE50bXllZEk5SE1I?=
 =?utf-8?B?NHpoZUZaaTVIQVFCZytNMjRPQzFnUXhVb1lSZVpVKzlYTVNtZytwTktKZS9K?=
 =?utf-8?B?OUZHRGFmZFF0WnFXMkcwbTRLSUkvVkpaNjExc1pmVWhEQUk3QlhCb3lJMjli?=
 =?utf-8?B?bG43cndUU2tRTnl5VXNES0pabncvb2VTKzRpTUVlaHhkQkN2K1p1WnBZVTkx?=
 =?utf-8?B?ckxRaDF2b0dqK20yamNSSUVKRXoyVnJoNTVrMXZTNzNSbkxCaUVmLzZ6dzcw?=
 =?utf-8?B?blY1UGhadjN4cGhVWDdwcnFWZXd5WEhlVDgxV1RtT0pXaXpYRXIzRC9VZll6?=
 =?utf-8?B?MWhDRm5EKytPMUVWRzdFN3VmSmJjSEMwZDRIQ2JyTUpkV2tOaThsMk95MzNr?=
 =?utf-8?B?am0zaDluZnNHMy94dllERWNWN1NxaTl3SUN0bi9Tc1UvZHpXaXQyTDJpczZT?=
 =?utf-8?B?akthRmgvcEljdGJhWVN6azRHL0F3bS9Jdlk4VGVSN0ZNdWpYdzk5Y0x1NVRO?=
 =?utf-8?B?ZkdUOFA0NkhSKzVXN05wS1p0d1dlNlRNQXpOSFE4L2dxTWY1c3J2U3ZRZjRF?=
 =?utf-8?B?cGNVR2cxN2tncGVVK0MwamFsU2VobUJtTEh3dzVtTmtYK1drTG9vcG9SclBW?=
 =?utf-8?B?aXFsMUFndjhnMTdHSTRhTmdCZGhQdlBwZkNMdVAzYkdoNmxmSjVCYnFmVzJz?=
 =?utf-8?B?WUxMeGlPcEtXUjR5ellPTnd0Y2luN1pWMmdNa1FjVndQTlB6WWNwU0hwZXB1?=
 =?utf-8?B?QlJ3eDNoczQ4UjNOc2E4aGdYLzdnT2IycDJHTm9nQ0hld1ZZL0szTEJqM1M5?=
 =?utf-8?B?K1o1MEgvUXVYaWxPckIwSlV1d2pXdTBuQnc3OFRvK255cFphSElOWE41M0d3?=
 =?utf-8?B?N2xSdmdzMjh5Vlh3VC9maURsQUpzODJBcVVha1pyNHc2NFNYTDN4Yzd2d1hh?=
 =?utf-8?B?UGRjL2V0c1JvTGs3U0tNNjJMUXROZVZEKzN6cDUyU1llOHJpMkNhTWMyd0gy?=
 =?utf-8?B?b0E1RzcraFNuR0JBdjc4R2RNOVRnUlFJQm1VdWtWNVZ4VlQ3RXVtWXVlUXNh?=
 =?utf-8?B?R0ZsZjZxWmlSZmpxbjRKU3prWUQySDM1clRuRG1VUFZSVjMxZzdmRnNUa3RV?=
 =?utf-8?B?S1E3TzUwM24vL1Q4L2xzMFc1am05UWEzSW5CME4wU2dLRnF5VGc3MkpkQkJG?=
 =?utf-8?B?c1pEOWphRGxoZm05VVdjODcxQlRKSDlKdy80TTcrVUhGb0tFWmt3L0VwQnp6?=
 =?utf-8?B?WUNNRUI1MmdaZnJnTVpNa0ZKTGZGbmpyUjdyVTVvdituK0dtVzJsU3FzSk0z?=
 =?utf-8?B?RDNoaDd3TDlkb1l4U09QZGNRUi9ubFJRbFhRUkxCcjB3WnhtR0xNSGdmNDIr?=
 =?utf-8?B?WFNtYlA0MGloMEJxczlmVTV4SkRuQ3cvT1lhdUJlV0UzbUhpQ3VIREgxTlMr?=
 =?utf-8?Q?9yYSSS0ZiPVlO14z17V0EpuAcXC489+Z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGRJcE1uY3FiUzJRUWpBZjhBV0IraVo5MXVtTDg0aWYxSGtuMnh0T0hmOUFS?=
 =?utf-8?B?Rnp4T3lIS0FVM3kzSGtyYjduVElKL2ZTdlhhVzQzNkJsL2l5aG5VLzYzTTdY?=
 =?utf-8?B?c0d3TEtHcWk0NnE2bFJaVXVUdWk5MlhWYzJlOEhYczNRem45VGYyeUV3d2xL?=
 =?utf-8?B?VkpHTXExclRoemFjY3hTQkZ3aHdhRDR6ZmRRenFpL1JpNXlSaHFDYnc5Y3Ro?=
 =?utf-8?B?REdlcFB1WnBVL0dJUkdmZGlNQmVXS2owaFVUeEdXU1NlMlJ2OXJMVlRBdWxF?=
 =?utf-8?B?SE0wYjJuRmVIY1pQVS9hc09SNjQvNHFTMUNKUklYYXVadlU4dUp1K0lLeFBy?=
 =?utf-8?B?K29uY2VVQmVwdWEremdVdlRMSmVNMjdHZE5neVRpTFpRYW9WbE5kU0RiS2Nn?=
 =?utf-8?B?YkZzVjFWVTdHYlZ4d0kybCsyL2RnUUI0dXpaMkR3NVdaQU1heVhXZ3VTR25a?=
 =?utf-8?B?VWExZTdCWFdOS2lQNk9CQUN0STRMNGlDcGJxbTY3am8wdFpjQkZYTVdWYy9p?=
 =?utf-8?B?eGprYzBpSXNWdHpSL21rVVlIN2RRSTB1VWZYcEEzS2xiS0xOSDhQdTdCL1ov?=
 =?utf-8?B?K2YwTWg1YlZRWkYwNjhRTllOVFkrWjZvcHhidjBoOGFCY0NIa1NQK1hqRmdK?=
 =?utf-8?B?MGtiZ0hnYlN6R24yQXVKT3d5cHBGYmdqYjE1L1Z0LzFtaERWMWVESWNIT2Iw?=
 =?utf-8?B?RTFpcUNHRHk4TE1WUlhDeXc1YW81RmFJRkxxN04rZHA3a0JyWnZqYTExcXJw?=
 =?utf-8?B?ZEFkQzBSTldvNjNtVGJwd1F5UlRnc0EzTWhyVStyVG1DYS9uSHFqTU9lS2h5?=
 =?utf-8?B?bHlNK1Avbi9VZkM5RzFXU2tTV3VkdlA5ZFM5dzY2UnBjdzNvL0tJalZ0cTZt?=
 =?utf-8?B?K1NxR0lhSFFsY2Jad2trWTZnSkxDV1AyM1lzUDhxcWxtYVZhNzQ1VlZhT2ly?=
 =?utf-8?B?ZWlVTWpQUlRtOXVKbkpPUTJkV1BCRVJzd294eUNHSTM2NmkrRkRlZk5pUGJZ?=
 =?utf-8?B?Vi8rd2lVQnlTK01HUXFrejhwODlCVFg0REdsK0VBNnkrcms2STB4SVo3NTdN?=
 =?utf-8?B?SFZBYldjdGN3RktpQmxLNXlpUE5CVWUyNlJ5eUdxdmlucUp1NXo3YWw5Y0Ns?=
 =?utf-8?B?dWcvL1loQTF0SkJJTlJmWTJPYTcwMWtFTDJ6elBsR3cwOVhBOEsxUHhGTnVX?=
 =?utf-8?B?NExySnpHV2xYalJOdGdqekNuTlZJeGZGUEtIZ3M4SXNQanlIVFYxZ25OWXVB?=
 =?utf-8?B?d1lMSExzK1dzVEgxaVB4Um05dEZ6V0JZRmlDV0lPdTQ5WHlMNmY0ZlZXMHhF?=
 =?utf-8?B?VDNoZ3YyQ0ZFWnRCc2FKSjZwbVhSZXpjRktCTGNKY3NpWlBEbFJ4NjVXRFhK?=
 =?utf-8?B?cmI0cWtqWUZKL1hoOXdoQU9Pa2FMMkVvMlZwc2wwUnlQRURFSUJWMFhKcGs4?=
 =?utf-8?B?SmM2WFRxakw1VkJzYkE4OUlGd091NXIzTnNvTjdWMmw3OUtTcTFoWXJ2ZU5Z?=
 =?utf-8?B?eC9VbXJjeEJjdGN1ZzVQSnJFZ1ZCL2JXRkgrbkIrRm5JaStYWDAxOUw1cGlU?=
 =?utf-8?B?QjAvR2lvWkREK285YmVHaklVQU5EZWhqVDNlVVNtbU04bUVueFRBV01heEIr?=
 =?utf-8?B?bUhlVzBmS096dzVqd1RDN0ZnVTBBVXpPNlpUY0kvWTl4UjduTS8weGYyaDEv?=
 =?utf-8?B?RDJ0NDUzWEF6Y2NndnMxcmJ0NlIvVXF4L29MMXNMWTI2dUIrcnhtakVva1Zo?=
 =?utf-8?B?eDU3enpjY01WbFlJNGFVdkVhZkJrdDN0dWRwRm9JTDhNRXQrd2hmdGNnUm9l?=
 =?utf-8?B?anFNWjJVa3hJYmZZb3YzVXg1NTFjcEYya3JQdEZoOWVQNmZSbDN6cmJGekxs?=
 =?utf-8?B?cStiSmNVMnJZZkZScU5BS0hQa0p0TGpCeENMV0hsOUdTQnpBM05KK1dZZ2JD?=
 =?utf-8?B?NzBFNFNIdWpaTFZvTzZtL0RkWDBUN3VvQjcvOFh4Y09LOENnaVVrN0h1R0FV?=
 =?utf-8?B?SXBvZW9aelR4bEpIOGN3TmcwVFcydUNBRmF2YjBzUkF5R0kyQzduUi9DNzAz?=
 =?utf-8?B?RlBtSWFack5RbHpUd3hlbm5LQ1JHNmIzOHlKcmc2NUlDT2xsdzhGR0M1aXh3?=
 =?utf-8?B?NTNmbmFqcExLcVpTQkhvV0djUG04RGxJeDErbUh6Qnd2cmV3TTRnQVZjNlJn?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5776d0fc-ac79-490f-d0c2-08dd575ada37
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 18:16:27.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dbzo5/Pf8eHHnlpmOfGO6NCDDZVNJJteyRENceSNnoJ1rwGQ8XooEA9cPN4Ib/VUSXql3Q8dVz/Ihm7CHYV2EYlbGrkbNgwvYDQOGFOjAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7141

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAyNCBGZWJydWFyeSAy
MDI1IDEyOjQ0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy83XSBkdC1iaW5kaW5nczogZG1h
OiByei1kbWFjOiBEb2N1bWVudCBSWi9WMkgoUCkgZmFtaWx5IG9mIFNvQ3MNCj4gDQo+IEhpIEZh
YnJpemlvLA0KPiANCj4gT24gVGh1LCAyMCBGZWIgMjAyNSBhdCAxNjowMSwgRmFicml6aW8gQ2Fz
dHJvDQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IERvY3Vt
ZW50IHRoZSBSZW5lc2FzIFJaL1YySChQKSBmYW1pbHkgb2YgU29DcyBETUFDIGJsb2NrLg0KPiA+
IFRoZSBSZW5lc2FzIFJaL1YySChQKSBETUFDIGlzIHZlcnkgc2ltaWxhciB0byB0aGUgb25lIGZv
dW5kIG9uIHRoZQ0KPiA+IFJlbmVzYXMgUlovRzJMIGZhbWlseSBvZiBTb0NzLCBidXQgdGhlcmUg
YXJlIHNvbWUgZGlmZmVyZW5jZXM6DQo+ID4gKiBJdCBvbmx5IHVzZXMgb25lIHJlZ2lzdGVyIGFy
ZWENCj4gPiAqIEl0IG9ubHkgdXNlcyBvbmUgY2xvY2sNCj4gPiAqIEl0IG9ubHkgdXNlcyBvbmUg
cmVzZXQNCj4gPiAqIEluc3RlYWQgb2YgdXNpbmcgTUlEL0lSRCBpdCB1c2VzIFJFUSBOTy9BQ0sg
Tk8NCj4gPiAqIEl0IGlzIGNvbm5lY3RlZCB0byB0aGUgSW50ZXJydXB0IENvbnRyb2wgVW5pdCAo
SUNVKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5j
YXN0cm8uanpAcmVuZXNhcy5jb20+DQo+IA0KPiA+IHYxLT52MjoNCj4gPiAqIFJlbW92ZWQgUlov
VjJIIERNQUMgZXhhbXBsZS4NCj4gPiAqIEltcHJvdmVkIHRoZSByZWFkYWJpbGl0eSBvZiB0aGUg
YGlmYCBzdGF0ZW1lbnQuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUhDQo+IA0KPiA+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvcmVuZXNhcyxyei1kbWFj
LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL3Jl
bmVzYXMscnotZG1hYy55YW1sDQo+ID4gQEAgLTYxLDE0ICs2NiwyMiBAQCBwcm9wZXJ0aWVzOg0K
PiA+ICAgICcjZG1hLWNlbGxzJzoNCj4gPiAgICAgIGNvbnN0OiAxDQo+ID4gICAgICBkZXNjcmlw
dGlvbjoNCj4gPiAtICAgICAgVGhlIGNlbGwgc3BlY2lmaWVzIHRoZSBlbmNvZGVkIE1JRC9SSUQg
dmFsdWVzIG9mIHRoZSBETUFDIHBvcnQNCj4gPiAtICAgICAgY29ubmVjdGVkIHRvIHRoZSBETUEg
Y2xpZW50IGFuZCB0aGUgc2xhdmUgY2hhbm5lbCBjb25maWd1cmF0aW9uDQo+ID4gLSAgICAgIHBh
cmFtZXRlcnMuDQo+ID4gKyAgICAgIEZvciB0aGUgUlovQTFILCBSWi9GaXZlLCBSWi9HMntMLExD
LFVMfSwgUlovVjJMLCBhbmQgUlovRzNTIFNvQ3MsIHRoZSBjZWxsDQo+ID4gKyAgICAgIHNwZWNp
ZmllcyB0aGUgZW5jb2RlZCBNSUQvUklEIHZhbHVlcyBvZiB0aGUgRE1BQyBwb3J0IGNvbm5lY3Rl
ZCB0byB0aGUNCj4gPiArICAgICAgRE1BIGNsaWVudCBhbmQgdGhlIHNsYXZlIGNoYW5uZWwgY29u
ZmlndXJhdGlvbiBwYXJhbWV0ZXJzLg0KPiA+ICAgICAgICBiaXRzWzA6OV0gLSBTcGVjaWZpZXMg
TUlEL1JJRCB2YWx1ZQ0KPiA+ICAgICAgICBiaXRbMTBdIC0gU3BlY2lmaWVzIERNQSByZXF1ZXN0
IGhpZ2ggZW5hYmxlIChISUVOKQ0KPiA+ICAgICAgICBiaXRbMTFdIC0gU3BlY2lmaWVzIERNQSBy
ZXF1ZXN0IGRldGVjdGlvbiB0eXBlIChMVkwpDQo+ID4gICAgICAgIGJpdHNbMTI6MTRdIC0gU3Bl
Y2lmaWVzIERNQUFDSyBvdXRwdXQgbW9kZSAoQU0pDQo+ID4gICAgICAgIGJpdFsxNV0gLSBTcGVj
aWZpZXMgVHJhbnNmZXIgTW9kZSAoVE0pDQo+ID4gKyAgICAgIEZvciB0aGUgUlovVjJIKFApIFNv
QyB0aGUgY2VsbCBzcGVjaWZpZXMgdGhlIFJFUSBOTywgdGhlIEFDSyBOTywgYW5kIHRoZQ0KPiA+
ICsgICAgICBzbGF2ZSBjaGFubmVsIGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVycy4NCj4gPiArICAg
ICAgYml0c1swOjldIC0gU3BlY2lmaWVzIHRoZSBSRVEgTk8NCj4gDQo+IFNvIFJFUV9OTyBpcyB0
aGUgbmV3IG5hbWUgZm9yIE1JRC9SSUQuDQoNCkl0J3MgY2VydGFpbmx5IHNpbWlsYXIuIEkgd291
bGQgc2F5IHRoYXQgUkVRX05PICsgQUNLX05PIGlzIHRoZSBuZXcgTUlEX1JJRC4NCg0KPiANCj4g
PiArICAgICAgYml0c1sxMDoxNl0gLSBTcGVjaWZpZXMgdGhlIEFDSyBOTw0KPiANCj4gVGhpcyBp
cyBhIG5ldyBmaWVsZC4NCj4gSG93ZXZlciwgaXQgaXMgbm90IGNsZWFyIHRvIG1lIHdoaWNoIHZh
bHVlIHRvIHNwZWNpZnkgaGVyZSwgYW5kIGlmIHRoaXMNCj4gaXMgYSBoYXJkd2FyZSBwcm9wZXJ0
eSBhdCBhbGwsIGFuZCB0aHVzIG5lZWRzIHRvIGJlIHNwZWNpZmllZCBpbiBEVD8NCg0KSXQgaXMg
YSBIVyBwcm9wZXJ0eS4gVGhlIHZhbHVlIHRvIHNldCBjYW4gYmUgZm91bmQgaW4gVGFibGUgNC42
LTI3IGZyb20NCnRoZSBIVyBVc2VyIE1hbnVhbCwgY29sdW1uICJBY2sgTm8iLg0KDQo+IA0KPiA+
ICsgICAgICBiaXRbMTddIC0gU3BlY2lmaWVzIERNQSByZXF1ZXN0IGhpZ2ggZW5hYmxlIChISUVO
KQ0KPiA+ICsgICAgICBiaXRbMThdIC0gU3BlY2lmaWVzIERNQSByZXF1ZXN0IGRldGVjdGlvbiB0
eXBlIChMVkwpDQo+ID4gKyAgICAgIGJpdHNbMTk6MjFdIC0gU3BlY2lmaWVzIERNQUFDSyBvdXRw
dXQgbW9kZSAoQU0pDQo+ID4gKyAgICAgIGJpdFsyMl0gLSBTcGVjaWZpZXMgVHJhbnNmZXIgTW9k
ZSAoVE0pDQo+IA0KPiBUaGVzZSBhcmUgdGhlIHNhbWUgYXMgb24gb3RoZXIgUlogU29Dcy4NCj4g
U28gd291bGRuJ3QgaXQgYmUgc2ltcGxlciB0byBtb3ZlIEFDSyBOTyB0byB0aGUgZW5kIChpZmYg
eW91IG5lZWQgaXQNCj4gaW4gRFQpLCBzbyB0aGUgcmVzdCBvZiB0aGUgbGF5b3V0IHN0YXlzIHRo
ZSBzYW1lIGFzIG9uIG90aGVyIFJaIFNvQ3M/DQoNCkkgY2FuIGNlcnRhaW5seSBkbyB0aGF0Lg0K
DQpUaGFua3MhDQoNCkZhYg0KDQo+IA0KPiBUaGUgcmVzdCBMR1RNLg0KPiANCj4gR3J7b2V0amUs
ZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0N
Cj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEz
MiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9u
cyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3
aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LS0gTGludXMgVG9ydmFsZHMNCg==

