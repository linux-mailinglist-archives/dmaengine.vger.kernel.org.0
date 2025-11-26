Return-Path: <dmaengine+bounces-7347-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E8C88778
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 08:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DF653505A5
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C1C30496A;
	Wed, 26 Nov 2025 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="WMe0goyJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07D2C08DC;
	Wed, 26 Nov 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143028; cv=fail; b=P2tOyheksnSw1QsdGTYDiwW8FwHdNMjwbnnReA6aiAUkCgEazZN6K0OeiQ9WM/S9fQA/Os4/64SU5AyQddyiJCY4oq7iK693bPHL5gr4gqmSgHS6oecIXZHjEg16YbgcXHT57nHrotO5Rfel2wP+0QP8mdoqbCUaTHCaxVFkiMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143028; c=relaxed/simple;
	bh=Fy2JBDVMx50ajMh4VX+cCH+3GTsadbV4W2pKtkAdWBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AG3hbk5wI4bF4wTfdKb/+PVGGm7tEAz29oyrFlVNtqKIdsuzuFu0JpkF5Axze3CwOnWpTeB78mTQFYO0XaQ4kF9EezVhHMVZrnkk2Li7ZosTrMP+OyB+WCU2OvbQ3FbwtcG+EnTbzk7Yqg/vuu8879FjVtOtxbLE3SSucJeUaNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WMe0goyJ; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZoDFPIlsyp/4qSpbEFWZCnZcip3RzdJmhkLIxWdcOfZoX+nWL8WA3KWr5R+Amyev+CgjCZUoUtTRGEkFyolWBg5Y0gNoeK+86IZLKe7oN02UEHnCfLKOPX6keAOvOrVNyLOqkK6iF5Xyj9bQw+SvFWL+1VqcehRcOZaFSPHEYHP0esuhy4y6qVDdbQGQAuE3rudCZkzHRGq98DCTEY/T7gQyZfPZMmkLckD7T0vtz4gQ/2nn+ICuYIt6Sc59uHZbG3lprzV5dMIAGm08PR6F7XF3PLmhYY28XKfoPBFXNE5hv7yddJk+Xmb/39xNInw6RTS/06nccx6L1gl/OabFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy2JBDVMx50ajMh4VX+cCH+3GTsadbV4W2pKtkAdWBE=;
 b=bJe+7qk3SzyQQv1gb3qXPuCUJ/2HkDYLXnXG/mhNJ1hzN8bw+I8asYBLseQuTEnRBjYXQb97ZBCZbbIE5U1WgQj5mbT+3U4yaGxVgfR4VOHeLYHyV1HvBtcidynaAe03VV7Yv/7XigoNEgTHzVZwe9khm/gH+ip+QRL/DLLeGcvg53Iwu7mJRqB5snvxhnfo92l9siBrvfMK0TEkrB6ijpQ0/Oot+oUeURxR7WtixZCnggCEmsJWE6RhIOUhPz1phyXYEWxaVit7cyiSbf2Rt71A184+iWGMcICYjLDmkCxCWHUp0Kqc04kOWagoh5PaTXkWv99ShWcfEUaWsuLVjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy2JBDVMx50ajMh4VX+cCH+3GTsadbV4W2pKtkAdWBE=;
 b=WMe0goyJvu+AwIzZKEjUj3VhbS9l64u/OcRWkZycedC0rrT6E8P3MSWH0oANSUJC07ptm1NHEXn8SBxRveJbgWEiRfSnJWyldkC5ubiPucIGodK8z2trxH36nSV0Z8tMmQk7c9uoMyigN+HB+cK15F/Vrf1GYcm1FB99oXMAapDkDl0S8c9NKh2UVRFknhpe3x2bqv3dUN00RGftXrlmR/EgnkBcKXyz/wjrnSWnDQNlTaZiqaBPisOvrmbPhH6bmyU/a4yC//KQmTwgRbsdvJeOFQ4/hWUqxM9qq5tzcAKkqXp07EzSlZvDDhvkTLpbE/uGDRqWUL6X8hpQT/5Yiw==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA1PR03MB6321.namprd03.prod.outlook.com (2603:10b6:806:1b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 07:43:42 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 07:43:42 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Rob Herring <robh@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add compatible
 string for Agilex5
Thread-Topic: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add compatible
 string for Agilex5
Thread-Index: AQHcWhEr2R2elBYtt0mM2TZ3IPKLVbT71CwAgAjIdoA=
Date: Wed, 26 Nov 2025 07:43:42 +0000
Message-ID: <e049a03a-49e3-4b00-a3e8-7560f63fa61a@altera.com>
References: <cover.1763598785.git.khairul.anuar.romli@altera.com>
 <bd19d05233cb095c097f0274a9c13159af34543b.1763598785.git.khairul.anuar.romli@altera.com>
 <20251120173608.GA1582568-robh@kernel.org>
In-Reply-To: <20251120173608.GA1582568-robh@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SA1PR03MB6321:EE_
x-ms-office365-filtering-correlation-id: 71bb933e-77e5-49e6-5157-08de2cbf8598
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2ZEZVljTVRnNlRzcmYyNFBTbXEwbkN1dUxWMG12MUZKSDAxOHltTXRwNmNj?=
 =?utf-8?B?ZTZqL2lReVJ1K05ybUpBbjlzWXE3SU9LcHlzUlI3c1ZDeExheEllRTE1bTE3?=
 =?utf-8?B?ZWhuR2JpOFArNDVZR2hIOFFSd3lpejBOL2cxRmRzTFpwd1NaOHIyL2toYURy?=
 =?utf-8?B?eTFhK1pvZk44K2lCSWl4emVSTlh3eWpEQUpCUnZGZWYxaVNKeldsYmpnUjhi?=
 =?utf-8?B?VzRFSEhORkp3WjZSMkloaEMzclVOc2E0SDQ4QXQzTlJhYTlOeThYL1BLQ3JY?=
 =?utf-8?B?cVM0d0w5dUdRUWp3Zy9RZFN1T0pRaS9neXRkOUpWUHl4aEVtUVhPOWpoTncv?=
 =?utf-8?B?R3c1V2hMclRCUERSQ3BiZEJBZlJXY25waWVmRFVlMmZRZmVocDREUEpkU3NY?=
 =?utf-8?B?eGhXSWJRZnpXSlppazE4a2RlSkUrWUVlYlZ5bXN0eW95M2lhR1NIaC9zNVZJ?=
 =?utf-8?B?L2Y3RVN3dVRyem9HNEpFYUJjSnBoakJxVkFLZzVlRFlUYkx4SzkrTTcrOERY?=
 =?utf-8?B?dHkyOWFXdm14enNlUGZNUldiL0pQdzFvSjN4RGJ1N0ZTdEliWXlFQWJTRFJI?=
 =?utf-8?B?eU85TG8ySFUwQ21XM1pSRXArQ1FPT2swNzZhOGwyTDB5ZHBaU3NyOGxudlh3?=
 =?utf-8?B?QmVBNEkwNllEeDczN0pRMldkRFAwY0krMitEQUlEd0FNaUNpbFBERGUzSSsv?=
 =?utf-8?B?QWVpZXVoVWhVeVNqU1VONk5vTTNEVXdDUlhuSTRGYkFFdmljdThRWVlNWnlj?=
 =?utf-8?B?YVk5NmpjNWZ6MTFLd241dHMreUtMMW4yZDdHY1JwRFVXRk9YRTQxZHhkdUVw?=
 =?utf-8?B?cHF1YzFqZUxKeFdHdDBUTnMvd0UvSlgvYnB3OG4xSnlwUFRQM1NJVjNJOXFI?=
 =?utf-8?B?NjdldXlHb3BuWTE2NXdnVFVydmthZEFmY2NvbURZUzVLc2lOcjJmUGFhN2py?=
 =?utf-8?B?TFFyakNORGR1RnFEUzhNMU5OU2wzUFhmQ2EvWnRaVGt0UWJDbzhnVCtGTWNL?=
 =?utf-8?B?NVB4aWgrcUg1cytlNVhFVnVvZEJDM2gwZE51NlRUejROazN2VjcyZ1d1WGhu?=
 =?utf-8?B?OFJsSEs2cHM2REt2Z2NOajlROVFQZUg2dERnL1JvY25QTXZ0NWdhcUtybVpM?=
 =?utf-8?B?Uk1UZVBsdWNNU2xpQ2dXS0pkRDZmOGtYdmpYcFBTeTlzV3Nzb2hzQzNnd3lk?=
 =?utf-8?B?cC85OGpFbUMwc1U3aVFyK2hLdkE4TW0rZ1EwSERjY2UzSDFuMElrZmFTc01q?=
 =?utf-8?B?d2FRN2NZQlpWRnl1V1UxQ3VJQnlxNnhXeTluUnlyRkdqWWhKVGwva2dLTFRr?=
 =?utf-8?B?dkh5c1MzRWFyL0lrMzhtMnUwZzdtN0N3VkZ6T3JRWmpSZnFYVEFuVlh2UmZ1?=
 =?utf-8?B?cW9aUHVPcFNySFlReEgwY0NGT2srK1ZtTm9Eb0JkcHJBL3BIc2xuTjFzV3JP?=
 =?utf-8?B?RFFWa0tCMXVqNGV6RTJKN29RN004N0Q4UU5zOU9rYjZzb0JhbG5sSjN5Q01L?=
 =?utf-8?B?SU9jaFpJRUp6YnlpQytmQ3R4QW1na1VvRWVJSFJHWGdqVVJXSVdiWlFBLzQ0?=
 =?utf-8?B?ejI2bUh5cTBuWmRKalk3TVRyV2w3UUVGNCs4N0xCRGtqMGhpTVhxOEZveXNY?=
 =?utf-8?B?NnoyYmlWcHdIRnpNNmdaS3ZlN2RHVEc1NDNZeWJXU0s0blFvZjFJWGtmMjJw?=
 =?utf-8?B?aG1TUXdobVNMWGZwVFVzSnBEQ1hrV2pPdVRTL1N4VWhGczZza081L3ZEV1o1?=
 =?utf-8?B?cklpeDJEZUlkMGZHRDVvaWRTMU1VOXczNGZhTG9tclJ1N05OVWo2aEFPZE9x?=
 =?utf-8?B?YkI1WTJPNGlRS2d0SzJrdW1Td2s2ZUhQckU5Sy9KcmhkVXJXWmlSbWhOUnJ1?=
 =?utf-8?B?WnhHelZLUmVjZHpXOUErSzkxeFBVbzRmakFtYVZ5bnBsRCt0MDNGcHFEbm11?=
 =?utf-8?B?Y0l4M0ppSXFBVXorNmpkRHhzeHZMWFZwRTZQN0R1MmJyZ0xkQk1IeFBWU0lv?=
 =?utf-8?B?R1RWVlVmSjQzdDc4NU13aU9xT2xRY0VtM3I2Y0QyYU1qQTV4N3dRcGZxdWJT?=
 =?utf-8?Q?Ew2L8q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2I1dXI4M01KS2MrMjZrbHZnM2JqMWhpZEFLdGpqRkx2RWpqRkRRbWZ0bDlT?=
 =?utf-8?B?SU1FN2lCRHg5SklqZUE4anNNR2F1WWphQm9XUmlSOEIxQTBZRm02MHFqQnJw?=
 =?utf-8?B?NG4xU1VjQmZoQVBFckl1cHMzYzZJek5XOWxmOUlXQ0lHbGU0dXNrVEtLODRP?=
 =?utf-8?B?amRYU0NCOUNtd2NSQk9aWGh0Z3ZFZTBrbEUyOGRHbkg4dDFNTS9IbTUxZi9T?=
 =?utf-8?B?a21tV0FQcHJnNy9sd0xJOEtLckpyajlpS3BWdW9MU2RURXRjT3RRZXRrUlMx?=
 =?utf-8?B?ZmVCRmltK1V3WklYT2U0ZHc2cUFnWkxCY0NJZ0VVVFhxQmZCMW1EK0hLR254?=
 =?utf-8?B?cityT2MzaGF6bzRLSXN6b3dKL3lSdEIvc0lEOXcya1FjTTdDZEQvdFdSUFJT?=
 =?utf-8?B?b01sUEoraEtKQlhvek9pTEJxbllPNFhVenJCUzB0YjRVUzdJVmRQV1hTN21H?=
 =?utf-8?B?MUxad0R2WmFMUU1kV0JpM1Q2V09GZ1VFRHMzTkZTOE51LzZNZ3B3NTQ5QW1Z?=
 =?utf-8?B?dXpheXNIQzdQT3dXSlJZL2FtN3dNTytMQXF5ekt5a3IrVlZGSE96MGVaTm5i?=
 =?utf-8?B?NGpqR3BpSkN6emtqcnVsWHN4S2RYREo4dkIvSmIyTWczYlQrd2NxbTRYcVVJ?=
 =?utf-8?B?VmlWbVd0TjY1SmVzUDEyWjhSU2Jqc1NUaWdpQ1dobFZRYjBtVDBVSDZoQnl0?=
 =?utf-8?B?TkVsdjVrWWdOVTVlT2lGQUVreEJuNjMyRW0weWRHRWNxbDRldEF6ZTVDMTZU?=
 =?utf-8?B?cG1Zb2JzZjhyYXpGaEttMUZqNzhSTmIwdHA0MVZHVlFXRXA3RWlNVTFPYkha?=
 =?utf-8?B?YTB0NzZJMTlxUjNWK0FqcXRmRXloRE94R0Y0NklKVkdqcFlwWC9sVDZ1Qnho?=
 =?utf-8?B?ajhtcTUzT3lVbEdzMXdLNUJIbGs5cDdoQjdyNFJ0SWdiWVNXaVFjeEFMZDhW?=
 =?utf-8?B?ZCt5Y1pTUkZtUFZ4dkJWMC8rY29OMCtNTkhUU0ViZW1VWXd1ck5zdlhIeWtV?=
 =?utf-8?B?Y01ueXF0M2lxRzY4d3pSS1ZmczRNRFlsbmRqQ1F4R3lhYlhHdGpxMUk2aWRh?=
 =?utf-8?B?K09kcXNuUkx4K2M0Mjg5TWNlY3JuL3VFOGlxRWNwQStmejFEdzJWUlRIaHlK?=
 =?utf-8?B?UmovVG9GUzg2WS9QZ3hLOSt0KzVHSnNBWUNNRGk5eDRSbGIvWU1JKzV3Tmdw?=
 =?utf-8?B?Wm9XbTlyMWhiRjlrYmVjOGhEcCtPeDdXU3psdStvQi85UW1mYlRURDYwazB4?=
 =?utf-8?B?aWNtYTE1d2JuMnJ3d09BYUlUYVNtNkdHWStXQzVnVWR2MlEyNW45NnRuZElu?=
 =?utf-8?B?NGRqZzF5blo0eDFRZDZpYnNxNFVPQ0c3ejR3aldrNnB0OE51enpOSU9haVFl?=
 =?utf-8?B?QjBIaEZuZy9Zc2FDRVdVbFNFOG9yWnpFUkZkK2x1RVR5eE9oNFdsQkRQQmhk?=
 =?utf-8?B?aGM5VjdiVExtWDdsaW95aXlOblpkbjVTYVV3WVYvbkYvRjcyY2dxU2dVU3R5?=
 =?utf-8?B?a0szdGEydlRlMnJNZENGN0tNaThrZEFqc25MWlB5Ym5RR3hyTHBoVG9SeFFY?=
 =?utf-8?B?U3JWWDdmTUtYb3JZYkR6bzRDbzVHSlQxa3NwUmFnMEdLeWdDNkFtLy9ZTC9j?=
 =?utf-8?B?eFpPalBzcGNSUVFqLzN5STcySUpaNDN1Rk1mbjFZUFZYT25pQzRmaXBHYW1X?=
 =?utf-8?B?bmN0c1BZUjM0R1BvTndKak95akZWWDM4L0lKQlRHYW1qVW82aTF1NDh2YTJU?=
 =?utf-8?B?R3NKTlpmYzZTb2orakZvV2lpQWp2Q2kvTmM5SjVsODhHelZiQXNpRWswNW82?=
 =?utf-8?B?RXhUbjYrMXduaVlVdkJrWTZldVd1NldGN2lSZVJsak1NOWdiS1dFbFVYK05m?=
 =?utf-8?B?UFlEZmpHNWxmVmQwcjJRMmFIZk1pc1p2cTRmclcrODZSbXArWDJYUEtEcW9q?=
 =?utf-8?B?SFNCK1AvQTAzRHRaYzZyZzR5V1VNRGoydTRMUFhzZ3B6RUFLMnFXY29qaCtL?=
 =?utf-8?B?ZjVoUjFUTGhDTFZHcXhTSisxcHZRWTZ2MFdjVHQzSXBuVVZoZVI0bUVFRFpJ?=
 =?utf-8?B?VFl2dUk0RzFheU8wbWhrUkxjVi9OOUpacnBLU3VjVG9XZ3Btdjkvc2V3VDlY?=
 =?utf-8?B?UGtHY2FnRHhyeG8vNjdDUS9PN3NVRGVzSE9KM3dUSGNqMFgvUHRNdFQ0WFVL?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <527F0F34FF03904982D9147B5E345601@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bb933e-77e5-49e6-5157-08de2cbf8598
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 07:43:42.4615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsDVQe9sHmhpWBy48SHIsGf9huGe6cELnWQCFgDNJ3MGdUJooAN4x1hyz4MdnU0EMffrVFzpblDp2/4lfF7nslop50oTo9gld5AWnZS6JHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6321

T24gMjEvMTEvMjAyNSAxOjM2IGFtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gVGh1LCBOb3Yg
MjAsIDIwMjUgYXQgMDc6MzE6MTBQTSArMDgwMCwgS2hhaXJ1bCBBbnVhciBSb21saSB3cm90ZToN
Cj4+IFRoZSBhZGRyZXNzIGJ1cyBvbiBBZ2lsZXg1IGlzIGxpbWl0ZWQgdG8gNDAgYml0cy4gV2hl
biBTTU1VIGlzIGVuYWJsZSB0aGlzDQo+PiB3aWxsIGNhdXNlIGFkZHJlc3MgdHJ1bmNhdGlvbiBh
bmQgdHJhbnNsYXRpb24gZmF1bHRzLiBIZW5jZSBpbnRyb2R1Y2luZw0KPj4gImFsdHIsYWdpbGV4
NS1heGktZG1hIiB0byBlbmFibGUgcGxhdGZvcm0gc3BlY2lmaWMgY29uZmlndXJhdGlvbiB0bw0K
Pj4gY29uZmlndXJlIHRoZSBkbWEgYWRkcmVzc2FibGUgYml0IG1hc2suDQo+IA0KPiBUaGF0J3Mg
bGlrZWx5IGEgYnVzIGxpbWl0YXRpb24sIG5vdCBhbiBJUCBsaW1pdGF0aW9uLiBTbyB0aGF0IHNo
b3VsZCBiZQ0KPiBoYW5kbGVkIHdpdGggZG1hLXJhbmdlcy4NCj4gDQo+IEhvd2V2ZXIsIGFkZGlu
ZyBhIHNwZWNpZmljIGNvbXBhdGlibGUgaXMgcGVyZmVjdGx5IGZpbmUuDQo+IA0KV291bGQgaXQg
YmUgb2theSBpZiBJIHJlcGhyYXNlIGFuZCBzZW5kIHRoZSBuZXh0IHZlcnNpb24gd2l0aCBhIA0K
Y29ycmVjdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYm9keSBhcyB5b3VyIGNvbW1lbnQgaW4g
dGhpcyB2ZXJzaW9uPw0KDQpUaGFua3MuDQoNClJlZ2FyZHMsDQpLaGFpcnVsDQo+Pg0KPj4gQWRk
IGEgZmFsbGJhY2sgY2FwYWJpbGl0eSBmb3IgdGhlIGNvbXBhdGlibGUgcHJvcGVydHkgdG8gYWxs
b3cgZHJpdmVyIHRvDQo+PiBwcm9iZSBhbmQgaW5pdGlhbGl6ZSB3aXRoIGEgbmV3bHkgYWRkZWQg
Y29tcGF0aWJsZSBzdHJpbmcgd2l0aG91dCByZXF1aXJpbmcNCj4+IGFkZGl0aW9uYWwgZW50cnkg
aW4gdGhlIGRyaXZlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLaGFpcnVsIEFudWFyIFJvbWxp
IDxraGFpcnVsLmFudWFyLnJvbWxpQGFsdGVyYS5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZG1hL3NucHMsZHctYXhpLWRtYWMueWFtbCAgfCAxNCArKysrKysrKyst
LS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZG1hL3NucHMsZHctYXhpLWRtYWMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kbWEvc25wcyxkdy1heGktZG1hYy55YW1sDQo+PiBpbmRleCBhMzkzYTMzYzg5MDguLmRi
ODllYmYyYjAwNiAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kbWEvc25wcyxkdy1heGktZG1hYy55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZG1hL3NucHMsZHctYXhpLWRtYWMueWFtbA0KPj4gQEAgLTE3LDEx
ICsxNywxNSBAQCBhbGxPZjoNCj4+ICAgDQo+PiAgIHByb3BlcnRpZXM6DQo+PiAgICAgY29tcGF0
aWJsZToNCj4+IC0gICAgZW51bToNCj4+IC0gICAgICAtIHNucHMsYXhpLWRtYS0xLjAxYQ0KPj4g
LSAgICAgIC0gaW50ZWwsa21iLWF4aS1kbWENCj4+IC0gICAgICAtIHN0YXJmaXZlLGpoNzExMC1h
eGktZG1hDQo+PiAtICAgICAgLSBzdGFyZml2ZSxqaDgxMDAtYXhpLWRtYQ0KPj4gKyAgICBvbmVP
ZjoNCj4+ICsgICAgICAtIGVudW06DQo+PiArICAgICAgICAgIC0gc25wcyxheGktZG1hLTEuMDFh
DQo+PiArICAgICAgICAgIC0gaW50ZWwsa21iLWF4aS1kbWENCj4+ICsgICAgICAgICAgLSBzdGFy
Zml2ZSxqaDcxMTAtYXhpLWRtYQ0KPj4gKyAgICAgICAgICAtIHN0YXJmaXZlLGpoODEwMC1heGkt
ZG1hDQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogYWx0cixhZ2ls
ZXg1LWF4aS1kbWENCj4+ICsgICAgICAgICAgLSBjb25zdDogc25wcyxheGktZG1hLTEuMDFhDQo+
PiAgIA0KPj4gICAgIHJlZzoNCj4+ICAgICAgIG1pbkl0ZW1zOiAxDQo+PiAtLSANCj4+IDIuNDMu
Nw0KPj4NCg0K

