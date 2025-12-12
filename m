Return-Path: <dmaengine+bounces-7573-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0349CB776F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 01:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1522300A9DF
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 00:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93322B8AB;
	Fri, 12 Dec 2025 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fBcLTDv9"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0B1DE4FB;
	Fri, 12 Dec 2025 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500197; cv=fail; b=tx02PhMI+4iHkyEDUXcGcNqvq/4m0kt/BDog8D6dp6JwKHLNHElU43nMn/hy2b+ZHcPsAZpBKyg7gQ419bD5rdssHlBbvjTV0A4smPqUE2L0da8Y3wYbgqx9895YmDdGQphV9gK/BYvD/hmuyFgM4q5s3NA+i4yXIotosaHTcck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500197; c=relaxed/simple;
	bh=Qn/TibTAf7MPQURNf58xlmmFev3OIivEgsxpIRz/fLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H/80AqSRcF9CLh2Gls7h4c6YJtuduvxB5m1avQH4QIokF92rWxRZVIVCp+RGle0DAGxNwT3H24Q3ZTyLJ0c4oVbjPb57em8xUYMAcz3VPPuuqypqg0tugLmqzTvAgPtTPHW0+muS2PsGgsOoUJ9XuUXV0zyZ9W3zZQYMF55muMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fBcLTDv9; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGon/Tg8KxQV3FErAOfK9njWxo2aKcCWhpAyLTdKl8bZG1ulYB6rSa3Ffa4oL0dm5/wpg8oZhOaUdiDdBP4sLWqYw5P2Ar+EhVZPrZ5LW+MLTqSflkBpLAADqkqKkVfcLVt6Cteph2vVXNvf74x925LNM5awQZK7kx1hVWO4E7FD4WZfiYj2d1lZ89/L03xXaQezdWZCVM2tp2VBXMJpY8cK1hl7OEOvX70LQN5ZMJIryqihM5XqILpX2KCDoETuLidTEvk/qxJq2hFCetdYSRN24nR8aJGXU+ThbXpQiEGIOw3xsUS1xBSr3njkQnVHivEA5ODY6BXwFi576x6GQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qn/TibTAf7MPQURNf58xlmmFev3OIivEgsxpIRz/fLQ=;
 b=YPbgJgeyrxKtibpMc0u3t83qnmjxU8cEkgvjrWloGyH4UFuhY//XbeZju0enPfDcXk2y8/cvFknsc47KD6XZdUfs7OV4d9AfHK9qYLpyCYyXey4hj8UnBEoF4EJzXF6foOhBtMIKjVML2f7yOMEcrdToPledvbcoTL2U/YBGL11IoPwD1gXkGPAZdnwFbAJBaA7ycs/XcXl0R/HerixunKb81+7++Mzpdn+nSzpWZXppCSr0jeLuLmniSlUL7k6kNX+mZMmrbNyh5GfrK7eQpDloIbX/Gkj0tnxH6S6BdPOLAKePms9MvdJO1SCQocL2x27bQQPfCCNF4v6OP7TgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn/TibTAf7MPQURNf58xlmmFev3OIivEgsxpIRz/fLQ=;
 b=fBcLTDv9HoYJJoti7tEB/+zQv8LTimt0sQrjcje497GVbuxoZmkZiUT7z75/GD2ng2GmBfrntVu8jUuyWKNFFMdi1IODLqOTH9jFtB8mQ6oJKoHWkJYZvdqndbLMem8BjG7/dntoLr6gPriJyuUIabSTTVrAePlzY7HbYR1+g/bsEEqWIC4yniWoRf4nRmTiFRKL9VKc5v7GncKJiwEJxY/iuU4rFJ4X6IciZZaloKIC47ljasVldjS0YOmpJTvUKsDVBld0fc+F7I1ApKsArGyuqgEhX0tyLy3YjXXZu0ysiDQ+Cfe0uSQeeVbac70K8ALtbnYjujz7fUWdi6sm0A==
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by LV8PR03MB7445.namprd03.prod.outlook.com (2603:10b6:408:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Fri, 12 Dec
 2025 00:43:13 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Fri, 12 Dec 2025
 00:43:13 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Rob Herring <robh@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Eugeniy Paltsev
	<Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add compatible
 string for Agilex5
Thread-Topic: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add
 compatible string for Agilex5
Thread-Index: AQHcalhRhGsjcCbE0EmrDnlaQuTML7UcldIAgACWFIA=
Date: Fri, 12 Dec 2025 00:43:13 +0000
Message-ID: <71e1f240-9ea6-4322-9fdd-7890154abfa2@altera.com>
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
 <21ceb1207564d9962c90d8235282f1e462df6875.1765425415.git.khairul.anuar.romli@altera.com>
 <20251211154604.GB1464056-robh@kernel.org>
In-Reply-To: <20251211154604.GB1464056-robh@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR03MB8447:EE_|LV8PR03MB7445:EE_
x-ms-office365-filtering-correlation-id: bd6f86db-bed5-4616-173e-08de39176e88
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFBIK1dDRHJ2THlmV1V6UDAyQkR4aHlCV1dhczFMWGtQMjlSZzVTalc0dzRi?=
 =?utf-8?B?QS9wMSthdHBWcTZXQ1FJZXdQYjJsajE4aUZxWStiV0NCeVlRUkFidW5qY085?=
 =?utf-8?B?YTloNlJxenpVd0pXTUxETTJQQkE0RnZxUy9Qd0RCcmxkZ3JhWk9BditMa3JI?=
 =?utf-8?B?UE5lczh5cm9ia3RuK3NrcW02V1BXNDhqK3FVbWlPc0FkalI5Z29iQTdIZ1F0?=
 =?utf-8?B?YU9VeHkxRHd4MkpwTXgyR2tQdEVTLzlHSW5NdzZsVm9VbDhhbFBsYW91UDZu?=
 =?utf-8?B?ckNnYVBqMEhtbjFkZzJBcnAycU5ubnQxZGdobGh3YXlSTTl4VVhTaGtKQkI2?=
 =?utf-8?B?QjlETzl6RGVYZ3BmdFNZL0VuR1VDMXdqL2d2UzVISXc3RFpyeU5DWVFQR2hj?=
 =?utf-8?B?MFM2bmIvQzdTMGpid29kcDBML2YwWEVCUDN5a0kvMEJBNFVGQUhJWWJpNUJv?=
 =?utf-8?B?VS9SU0dFNmJJZUlsWElRTHI0cmZuS2tIOEk0STRlbWEwWWZjU1ZwbjZET2Ew?=
 =?utf-8?B?WGJiWlY5RnVqWWxESGpxN0J2aDJIMDRIZ01YZnlic3JzYnN2MUoxRnN3QWVK?=
 =?utf-8?B?a1lUeXh2MWRxdllzbEUrRUFCd1RKc08zT2NkY0t1aFlWWGFoSjdJK2thU3I4?=
 =?utf-8?B?Z1VSOWpwcEdzZmVRMUYzNzVENGcwS3ZMSTg1Y1k3dTJSTGkvdUg3OGVMK3BP?=
 =?utf-8?B?M0F2cUhpWUVNMC9PSHB0SjVoamRncFdKd2c5TDFjQjJscGduZGEzckVDa3Zo?=
 =?utf-8?B?UnVwdlR5L2ZwbFJTZUNBZmFuTDhqQU5vMjdDcG1DNzlRUlZmRVh6K0cwSk1i?=
 =?utf-8?B?YmtwekduRjJTRzNmZHgzVjcwSjViL3VWN2lkcGk2YXZua1FDTTQrTDQxWk9w?=
 =?utf-8?B?OXpVVjI2MitDRjltUEg2TDRzaFRwUENPMWxXMmpoQXR5V21VNk9tZUViM3Zp?=
 =?utf-8?B?QXYyekFuNGRxMm5UaC9LcUUyTittaU1GK0FmYWhiK1lubFhDMWsxRmRSQnlk?=
 =?utf-8?B?dU9MdXpPemhGSS9GU0NNS2dqeXVQdjFPbEx1MTkwWExqTlFHL2wvL1liOHQ0?=
 =?utf-8?B?R25pYkhvdzJoazFmMTVUdWJsdWtVUEoySFRTU2RNWkU5bk1XaCtNbjYvQ09X?=
 =?utf-8?B?d0JiK0Ryb2tZSlVCV2ZxcVRINWNPWWJrSHdNbURFWmxZei9ucGErSUZsMXVX?=
 =?utf-8?B?UjcyTzU0RCtCRUVxdGUwUWdYbnpuUjlJLzd3SFdPdC9qM0VFaVdzSyszZjNU?=
 =?utf-8?B?SFpNUCsxQlJXSEQxMjV1Y2pYeFFyaEhHUDgxZmhyYkpTSFg4U2ZRV1hIbStv?=
 =?utf-8?B?QW1hVzd1OS9nTW1KWlh3Q2lkQTkxK2VUVDB3V2IrditGWThZNWY1RTY1TTRw?=
 =?utf-8?B?SnEwMWl2VFpMZldwZkFnMVowWHErR05FamM4UHNkbTcxa3FwMnNrcnlua0N2?=
 =?utf-8?B?TjJYQUF0NWVId0liL2drOFdyUytBRldHazJvNFkwcEYrclM1TGJsUzlCWmsr?=
 =?utf-8?B?RGRvL05qRTVCTklnbDV4RDJ4bHJnYVFVZFp2NlM1NVF4Y0VxZS9wT25QaHRs?=
 =?utf-8?B?ZmJmSjR0Ukt1OVBBZVZFelQ4OHNtQ25oQjZKOUtmNGxOdUtzR2NDQnl4NHBs?=
 =?utf-8?B?RFJWQlIvSERKK3lCemwyRVltVEUycnJpdkdRRXBJVXI1ekp3QVdmWjhuN1M1?=
 =?utf-8?B?N0cvdHRVTCthbjdMUk53YnhhOUV3UVhwMVZzSGpPczlsMHZvckwzcHkrbUlo?=
 =?utf-8?B?S09aclVuT3VMODVwKzNCL09sOUh1aFp0WTZMSHUxK0RVZXFJSnZrMW9yc3ZD?=
 =?utf-8?B?QVp0clFoeUZyL2pZbnhhV0xlZW1nd3VubnJvRW1Ra1FvcmxOM0hobFVwY081?=
 =?utf-8?B?eDg4RFdQckFUZHkzZHl4SGFtME1MeTRMN0Jqa2l4NU9YbGxIK203Vk5LV0c2?=
 =?utf-8?B?YVR3ajViKzFOWURCT2JGUkd1dkR1TnY4TWo3VkNDV0ZZUjhPRUIwNW1hNUtI?=
 =?utf-8?B?QnlpODRTa1FZSFZ4RlFKZDI1cmxaWmF4VkZiR1A5bEJiYzk1N3hyT0o4ZW5J?=
 =?utf-8?Q?GvTkR5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUNSRy9zQWtPaG1vTXJFcHpaWkhySm1pOUJaMUpqWDcyZ2tVaWdwUFZFT1pT?=
 =?utf-8?B?SWQrSlBJZ1lJMXYvNkhBVkorQjVreHJkRnhFdGp4aFlackgzWnhCSWdEMDQ1?=
 =?utf-8?B?SjBXa1lycFQwanVHRzlvT1dWc2dQdmhFME5kYkk5WW5sZDM5Qy9sK05waC95?=
 =?utf-8?B?TnZ0d1lqVzVlM3hsNFA5d2ZvdnhhOVlJdzRKKzNUbjIrbEI1QzN4NTZKOXI2?=
 =?utf-8?B?dnBBMGN0SlQra0h3eXFoR1VnYTJCYnFzQXIrd0llZXB0WmZxMktZQ1VwZHhB?=
 =?utf-8?B?UjN1MjJaZjRHQ3VqU3NpbmhQMVMycnBsazBKSi81RnhLNHBTK1g0RGpGL3Ev?=
 =?utf-8?B?ZlFRQlVOcW04YzBHcWxBbW0zalJmVm1JbGY3UEVqcUVmSXZaM0V5RE5OZFNk?=
 =?utf-8?B?blR0akZMRm9RVWpUbC9qazcvSGlTbUg4VTJUaDdxMHVDczJwM0RhN0dzOFov?=
 =?utf-8?B?dWN6MDVQWmpYMkova25ONzRpODRCMjM1ZlVEVDBSL3BpYUdTZzVNSGJ6cmZm?=
 =?utf-8?B?REVzQkF3d05vMjIrcXdrVHU1aDNldmFKR3N4cWx3NVR3RlBqR3FqY0lwS0tz?=
 =?utf-8?B?MzJxV2pROHJueWhHcUE1T2xaOE40c3ZMVk8vbDZiNGVuazBVQlZoaW9jMGg2?=
 =?utf-8?B?TGZtbnRaSEJhWEFuclk1UERQNzlXMHl1VVk3MW5QOGdiV0lLVDBtZFNWMlhy?=
 =?utf-8?B?UmdtZkpodVAweVc2cHNyL3FRNzRBWU5oSEMrTFFTYmN1NkUyS1BIQzZPVmNX?=
 =?utf-8?B?WmsvRytDZDdSN2Vwd0haVWNTc0FBeWh0UGJjeW5BekcrUFB4OTlyZ2c4bE4x?=
 =?utf-8?B?a3ZBTXYrbURhVi8zT3IxTk1FRldSTGdhS3FiTzdZemY5cjUrRnlML2pvL2hZ?=
 =?utf-8?B?SzNjSzYxZzBVQUd1eTRyVU9MY1lPZW9Jb0JySndlZWNReUhaVkJkSmNPWlI0?=
 =?utf-8?B?MXJhSC8waG95eGI5ME11dVpOR1NpOXJoelJtdFdpU0FDdG9oWG0wNVlpcFV4?=
 =?utf-8?B?UXFNVFN3L3pFZDcrT2tLNVVoOUFncW9sSGN2SkwvWm1iMjNUNzFVKzRMMG9w?=
 =?utf-8?B?RmcydlRNTGprSytML0QrazRCSFh4MkpWVWRhZXpkYUhYL09lYytQL2ZnSnBQ?=
 =?utf-8?B?RGFybGtoZjRFM0FicjZxdktYSklCWW4yTFBnOWt0S09mT0pEVmpNUEVmdnU0?=
 =?utf-8?B?Q0pLWlR4UEtQd3RGVjdVTHNWRk1RcUxmSGVteVRESGg3VWxjTE1Eb2lHcGJs?=
 =?utf-8?B?Qy9NR09wdDB0SEROVmZxdUJlTy9IeVAxeGt6aFcxbml4UUs2dW01WlZRMElq?=
 =?utf-8?B?UG9XNEQrTnRvSW1PSzdTRE0rTlNnaVNIc2k3MnlBdGx3UFVkWWZ4QXVLbWRF?=
 =?utf-8?B?TEtiN2l3anhKYzNQb2ZiRFAzMTVOU1QvKzlOYzBrWi9ja2trYjZDakpRb3pV?=
 =?utf-8?B?MzdGVkhUNWN5TEFlZ1RWY2UzUDdFL2RGZmVoSmVML0U4NzQvbEExTjVnVSth?=
 =?utf-8?B?bFRlei9CVEN2WHR1bXFIUllUMkxBM2tqaVZ6dHk4N3JLeXA5dmVIaWZHMUlD?=
 =?utf-8?B?c2JVc3NqZS9sOUxSUVhlRHV0dU41OHIzV3pZR25oRktGdkNYbjFueGFMemFJ?=
 =?utf-8?B?NFNPNnYwWllMclZ5Z1E5aDhmNTAxazVIMlpwUFBoQkhCajVodjk5N0s0eUhj?=
 =?utf-8?B?b3E1VklpdzBXYm93bGVaOW5sYThia0IrNTZNdHdIeXpRMzBiVkN0S1pFNFdF?=
 =?utf-8?B?SXFOblJLKzhVMENPL3RkVmlENXJjSnA3cnlPekFkNEREKzZZUFRPcngyczY3?=
 =?utf-8?B?NjAxbEswRzFXQkNWYVJmTVZ5a1pRWE9pcjVHbUpnS0hEM2VjWVVyWUNlOUpP?=
 =?utf-8?B?VHdlTmhyV3NyRk1XL285SHRUQ0NleGcyV2dBdzVabW8vZmc1T0tDVytNNjAx?=
 =?utf-8?B?ajVSaVZSWFc5eUV3bUdLaXd4T3gwbVQ1aEJ0cFhNeVNmbDhWUUFBSHlvYlZZ?=
 =?utf-8?B?RW8wNThGRTltWHVDU2wrdWUrQ2RCN1ZkVWhmYVFxdnh0dXU1VDhWYkwzS1ls?=
 =?utf-8?B?cC9wUXByMi9JSTFQNmtYbGFBc1pxejc5V1preXFqTXhEcnIxVWU0WmtBK1Zk?=
 =?utf-8?B?M0FJRW9Kdldnd1k3ZHVuK3UxQ0N3VnVHclZ0UFpZVnJ5NU9BaVJQL0tLelJ6?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04C2F697E3E5F6498C7DE1977EF1CF41@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6f86db-bed5-4616-173e-08de39176e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 00:43:13.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ac9jDKxcHa0r6Y/OQr5BlD+ddAJK8MkS4Kn+OyCPDczNUj9Rm80FRE5O4jNmGaUdNKf+fVbmcI54G1ljRZAUw0wNSX0JkHoFQHGbHi8tIoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7445

T24gMTEvMTIvMjAyNSAxMTo0NiBwbSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFRodSwgRGVj
IDExLCAyMDI1IGF0IDEyOjQwOjM2UE0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkgd3JvdGU6
DQo+PiBUaGUgYWRkcmVzcyBidXMgb24gQWdpbGV4NSBpcyBsaW1pdGVkIHRvIDQwIGJpdHMuIFdo
ZW4gU01NVSBpcyBlbmFibGUgdGhpcw0KPj4gd2lsbCBjYXVzZSBhZGRyZXNzIHRydW5jYXRpb24g
YW5kIHRyYW5zbGF0aW9uIGZhdWx0cy4gSGVuY2UgaW50cm9kdWNpbmcNCj4+ICJhbHRyLGFnaWxl
eDUtYXhpLWRtYSIgdG8gZW5hYmxlIHBsYXRmb3JtIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gdG8N
Cj4+IGNvbmZpZ3VyZSB0aGUgZG1hIGFkZHJlc3NhYmxlIGJpdCBtYXNrLg0KPj4NCj4+IEFkZCBh
IGZhbGxiYWNrIGNhcGFiaWxpdHkgZm9yIHRoZSBjb21wYXRpYmxlIHByb3BlcnR5IHRvIGFsbG93
IGRyaXZlciB0bw0KPj4gcHJvYmUgYW5kIGluaXRpYWxpemUgd2l0aCBhIG5ld2x5IGFkZGVkIGNv
bXBhdGlibGUgc3RyaW5nIHdpdGhvdXQgcmVxdWlyaW5nDQo+PiBhZGRpdGlvbmFsIGVudHJ5IGlu
IHRoZSBkcml2ZXIuDQo+Pg0KPj4gQWRkIGRtYS1yYW5nZXMgdG8gdGhlIGJpbmRpbmcgc2NoZW1h
IHRvIGFsbG93IHNwZWNpZnlpbmcgRE1BIGFkZHJlc3MNCj4+IG1hcHBpbmcgYmV0d2VlbiB0aGUg
Y29udHJvbGxlciBhbmQgaXRzIHBhcmVudCBidXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2hh
aXJ1bCBBbnVhciBSb21saSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4gLS0t
DQo+PiBDaGFuZ2VzIGluIHYzOg0KPj4gCS0gU2ltcGxlIGRtYS1yYW5nZXMgcHJvcGVydHkgd2l0
aCB0cnVlIGFuZCB3aXRob3V0IGRlc2NyaXB0aW9uDQo+PiBDaGFuZ2VzIGluIHYyOg0KPj4gCS0g
QWRkIGRtYS1yYW5nZXMNCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvZG1hL3NucHMsZHctYXhp
LWRtYWMueWFtbCAgICAgICAgICAgfCAxNiArKysrKysrKysrKy0tLS0tDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL3NucHMsZHctYXhpLWRt
YWMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvc25wcyxkdy1h
eGktZG1hYy55YW1sDQo+PiBpbmRleCBhMzkzYTMzYzg5MDguLjFmNGRjZjMwOTJjMyAxMDA2NDQN
Cj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvc25wcyxkdy1h
eGktZG1hYy55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZG1hL3NucHMsZHctYXhpLWRtYWMueWFtbA0KPj4gQEAgLTE3LDExICsxNywxNSBAQCBhbGxPZjoN
Cj4+ICAgDQo+PiAgIHByb3BlcnRpZXM6DQo+PiAgICAgY29tcGF0aWJsZToNCj4+IC0gICAgZW51
bToNCj4+IC0gICAgICAtIHNucHMsYXhpLWRtYS0xLjAxYQ0KPj4gLSAgICAgIC0gaW50ZWwsa21i
LWF4aS1kbWENCj4+IC0gICAgICAtIHN0YXJmaXZlLGpoNzExMC1heGktZG1hDQo+PiAtICAgICAg
LSBzdGFyZml2ZSxqaDgxMDAtYXhpLWRtYQ0KPj4gKyAgICBvbmVPZjoNCj4+ICsgICAgICAtIGVu
dW06DQo+PiArICAgICAgICAgIC0gc25wcyxheGktZG1hLTEuMDFhDQo+PiArICAgICAgICAgIC0g
aW50ZWwsa21iLWF4aS1kbWENCj4+ICsgICAgICAgICAgLSBzdGFyZml2ZSxqaDcxMTAtYXhpLWRt
YQ0KPj4gKyAgICAgICAgICAtIHN0YXJmaXZlLGpoODEwMC1heGktZG1hDQo+PiArICAgICAgLSBp
dGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogYWx0cixhZ2lsZXg1LWF4aS1kbWENCj4+ICsg
ICAgICAgICAgLSBjb25zdDogc25wcyxheGktZG1hLTEuMDFhDQo+PiAgIA0KPj4gICAgIHJlZzoN
Cj4+ICAgICAgIG1pbkl0ZW1zOiAxDQo+PiBAQCAtMTA0LDYgKzEwOCw4IEBAIHByb3BlcnRpZXM6
DQo+PiAgICAgICBtaW5pbXVtOiAxDQo+PiAgICAgICBtYXhpbXVtOiAyNTYNCj4+ICAgDQo+PiAr
ICBkbWEtcmFuZ2VzOiB0cnVlDQo+PiArDQo+IA0KPiBZb3Ugbm8gbG9uZ2VyIG5lZWQgdGhpcyBi
ZWNhdXNlIGl0IGlzIGluIHRoZSBidXMgbm9kZS4NCj4gDQo+IFJvYg0KDQpJIHdpbGwgcmVtb3Zl
IHRoZSBkbWEtcmFuZ2VzIHByb3BlcnR5IGluIHRoZSBuZXh0IHJldmlzaW9uLg0KDQpUaGFua3Mu
DQoNCktoYWlydWwNCg==

