Return-Path: <dmaengine+bounces-7471-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C169DC9C0F7
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72E394E4B88
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F93233FD;
	Tue,  2 Dec 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m3ZIaPvA"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C43242C1;
	Tue,  2 Dec 2025 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691104; cv=fail; b=TTuqtY8HIBecx6HP0UXqQWJ8iFVUKT+YTtFoPKJ1goKejxoOhRII01HWT5VlbF4gUICGwH4QNRf1/zi3ND5fa7R+9x4UHQgzmO09b1fJUYtWkpp58Rr0Q5i22MuDLaaAUClQ6peuI2rQK11DH+fw8XD0zw1FzppMpY36ZZSYPes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691104; c=relaxed/simple;
	bh=TKpwlPqOdjiyxyjTM1Dk4mrIp+1X0e1+87JVxmh5w3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K9O+Yy/2GCGcFLI6oMLo02yEUc5uj5hs6Pd+yQUSF/lvPFzeiIpGD0SU7Ddi62mJDNRbL3MmK+2qpRDzK7ie7Nmw3rtniWLWjVCXJPxp89aCi0nzbRlW13JEI/U/+Vtqp7qpGLFqXfenmOdT2s/6x7wsIav+FZ4YxAqkAvmP/rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m3ZIaPvA; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8aEmHukXrwNtn9Ikhi0NabIEQpu0aUNvMU5YIH8y5wjUrWalV0K+9dyTV91AxiqHZf17kyRdYEb4yl2x4JsTpTjwGUZPyvkbGhY4bSqdgacB1X6EusynWDxeGdpoEuO01LAGGWuBclOW2zbkUjwwu5mU88BoNDCyJ4mCOz9FM/0WtbhiFDpyKzyk1JPblrA7kR7utiwTEMViyyYVzjg8u9sNd41701rRzleAEmtevo42Wed0IIIaKkorZCd1EBKwxyfNXBOTiMeAjYK1mZFTAB1dM7orldykG6jZUHbmgi6yevzARfUuNrcoqzWjxuUh3EEJRHTbOd4DSSfEPAIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9sp3fB0rDXrVuMKl7vZo+tyviAHANyMudbeXQGXHAY=;
 b=W1KttGi02ONXUNFRHfglgJaI53r9h89md7Jiqri3DlAeSlC+GfIpOp8wmKJlhh/eNFcw41Sw8YP0e3JOqgMXAbrQfI+tWPnwg95Qt27gcoovC9pqGQdx01AcXFAiX0GsgiSTDyoQlm5s5jvd7FNZejliSxqsnqeZILEgBJhXHut7VFR+i1d2cLhNwjPKoRmzJsVlQ7S/o6/peS6gu7/71nnmxqZg7hcZXVz/x7jejtZzluuKxRkJvcl/vnzew1rgNvo/WUX1R3n6eIMMD5MtoknN3vGojuV9yxUg/RO9QWcpcMnwsGzHanrzZDrxEXWe6JNp1uwAMidwHjFTzt0LFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9sp3fB0rDXrVuMKl7vZo+tyviAHANyMudbeXQGXHAY=;
 b=m3ZIaPvA4iexUTjywt2+k1GkyuyRrXDDknFNcT4j4NUClnFGbrsi+J9IQ+cgWAMTWCA89Rqg6Rt6kLS14TltVCaXlM/6wCL6rqH1nDewnga9SUsLUV584IbJkC4b7ReIuWQThzj8EWSXHGlSwduH3YA9jSYPkeGDPFPN0VJU12VcOLQ7axNzQwaWZCNMJs3RVkFMv7CHISoX8NAW8q2tgIGhSeS+jauJnu8HwYmQ4ak8OFxGVkBvDyu7UcfCNwhBc3pqaZIMtQCoEULGMCeYgtpJmXtnFMMV1lpy8VA61CEljmq1o/wiWgVqa6iOmfF/mO8BD+x1ZUdam61+dcXO0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 15:58:18 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 15:58:18 +0000
Date: Tue, 2 Dec 2025 10:58:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 04/27] PCI: endpoint: Add inbound mapping ops to
 EPC core
Message-ID: <aS8MkMlNOaLANauE@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-5-den@valinux.co.jp>
 <aS3qW0LX/ueo2ZP6@lizhi-Precision-Tower-5810>
 <dqqewhnmesylgqmj7vohhwxs3aqemysgkymayst4p24yhkgszv@prztzziimnx5>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dqqewhnmesylgqmj7vohhwxs3aqemysgkymayst4p24yhkgszv@prztzziimnx5>
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd57fcc-afa6-45aa-ea7f-08de31bb9c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|19092799006|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFFmbEdzT0xyZzU4K2FqaHU2ZkxKR2dNS3FXR2JmQnhuNWV3VlBUOEo3VktG?=
 =?utf-8?B?RitlbkNqN09QOVZWbzVuWjl5azFuTGc3TUJ3cWRUQmk1cElsb211cUtTRWRM?=
 =?utf-8?B?NVZYRlBrNk9zWVdVbjJrQXlPeTMza1cxcHlnelczWFRsTDdiWWJaZXNwUzgz?=
 =?utf-8?B?bzhEUEdIZmxmN0p5ZXNKaU4wNDVQbUdZdjZzV3F3MFB6V0s5NWQ2ZnRrSlJV?=
 =?utf-8?B?NjBVY2NHZlk4dDEvSUMwSEhuSnFML0FhOW1JUW11aWt2Nk1zdGp5WCtzMHN6?=
 =?utf-8?B?alBCcXVyckV0T1hMeDVWdkZPK2l2aHp0RmxlTENiSjJCTGloQnpXYkF2Rkli?=
 =?utf-8?B?Smw4Yllzb3VWT0o0QUY0NWtHTFNqSm5kdVZXaFdhVlFrVTllOUFuSnFtWjR3?=
 =?utf-8?B?dU8vbSt6aE9lK1p2eXhYdGF0UnZCZ1cxd1dmaUVORVlXMFVqK0JOZGV2VkFD?=
 =?utf-8?B?OHdzSktYcytjQnIzdlRnNjIwQ1JZTzR6ODVQd3c2amtOWVJiZzRKNUNlVGtD?=
 =?utf-8?B?M2IwY05RSUh2emhUQTNtY0JUaHNURDY4YTRidldsYjNLc3g3OXhpYk5EdWp2?=
 =?utf-8?B?ZjJLdGd3bjROZHBvQndpWWI3TGU3dWpybis4K3JHSk1VWHNGSjdlcE9LNHd3?=
 =?utf-8?B?K0NadndTaW0yNFhvOTYyMmlyL2ExRXR3SzJtM3ljenhmM2hJeVJNNzlhbTZa?=
 =?utf-8?B?c21DUHp4TGZOMUlCZTNaRHpaRUwzMVdZZHErckRRRitCdHQ2dEw2RUJtaGUw?=
 =?utf-8?B?VFJHZWNKZmpIYnRsUVZTbHRSeXkxeWJ1anVxTFhXVmhsVnZwZHVkQVEyeGRy?=
 =?utf-8?B?R0I5bW9xVUw3M0pxMnBWT3hHUnN3QTJsRHVBb1RVajNQRXVEaDRiTkM0SGpz?=
 =?utf-8?B?ejAyL0tZZnVDcVc2QUtmVlV3VkI1NEViRjFZVDBOemUvVSttWWs3WHZFeTFu?=
 =?utf-8?B?QW9OT3EydThHMWtra3BOSVRsMVBNYk5PMFk2eXBNbzF5d05HbTJ0Z2duUXZx?=
 =?utf-8?B?aHVHZDFkMEwrWm1wVWEvdUxrWTRmQmMrYnFrdFovTElUYzlOT0xBTUpLemJ6?=
 =?utf-8?B?UW9wWHFNREUwbzJadWkzYlRubkZybmNxREQyditWSWQ0dDJPQlY0aHlSbEMr?=
 =?utf-8?B?a3Z6SFFYK0c1VDdOSWdHbzMreVlBWGtYd09RK01HVUdheGVCMXR3Vy92NXRE?=
 =?utf-8?B?aXB0MEg0YkcrdkdGWnNBcE4rbVl6WmMrb2VYYUZNQWtXT0UxQ2huTkdJL3Ro?=
 =?utf-8?B?WDU4a0t0VFhpM0RVVkFzMGI3QzZOL01mMDI4TThhVDE0K0krNXFsK3FwMm0x?=
 =?utf-8?B?a3NCeE81aDN2QlhuQ2NMVTQ5a3dZcGE5b0hiTS9pYlNVd0FYeXRMVUk4RDY1?=
 =?utf-8?B?ODVoM2FBOTBhUlEyWlVkUVN0Q08xeVpMLzZ6TTFjdGRzalR4WFdCZCtrT0VJ?=
 =?utf-8?B?WTQ4Zm1LbVVkMW9FaE1DSktuZGI1dUVmTUtSUHZRNmo1cGR4Wm45cVJPbUdw?=
 =?utf-8?B?MEgrRWtJejU3ekwvenBIVEV3Q0pJWlBoRk0zd0hXZ1NSRUwyR0tTLzM1R3Fu?=
 =?utf-8?B?MldyRUtlRUhRRUVFN0ozZGRYbDBxVlNVV0l6akZ6cEpKTW9Tak5oOFFlai8v?=
 =?utf-8?B?M1I0UzQvbUJETnF4cjlvc3dQUkFaMVFhc3VTaXJSajlKVFpmTTN5dkZoMU84?=
 =?utf-8?B?RnJ0dHFGcU1DYVhsOUhsUHlPQ3VtMzVnOXpYK29NdWdsUnJKbUFJUndLaGR0?=
 =?utf-8?B?eVpFWFJCZG85WUErcm9KTlg0WmdONXpzaE52OXVZM3Brb3VDZTQwM2lJRjlm?=
 =?utf-8?B?cGFaRUwzSXQyQVdteFhyamtncGk5TldrNXRqRE1XS0RNb0ZXbUlrdnFiWjYy?=
 =?utf-8?B?cmpMTUVVdXJ5dktxR0dmRkdsaXBzMWlyTVMzeFdVbEZCOVZrRVA0R2Z4dTFO?=
 =?utf-8?B?dkNHZlNPWTlaREV2Qmx5T0NGRCs5Vml0QnYzRnVvNVcrRDk3MC9sZ1ZoZlQv?=
 =?utf-8?B?TmNRdVZSME1weUQwc29QU2QxLzl0dnVmS0s4L1Fwdmp6VzA4OFRsajJ5d1l4?=
 =?utf-8?Q?yS5g7q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(19092799006)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmVobWp4ZktQMEVya0ZaV3pvdm1RT2ZVK2N3c2N0TnZaamtlaEkvbjdDOFM1?=
 =?utf-8?B?SzVydzF3REpBRDJyZnRoazlVTkpySzN5WGZRUnQweWF6aWN5WVFBcS9QY25F?=
 =?utf-8?B?cllCQVBjVXB4YmFaNURiSkRUa1V3SHhwQUF4SUdiREt5OUMxcmhrMDZnQXRl?=
 =?utf-8?B?MEtkbHpQcUFxb2t5N29VNHFscC9WbWdqK1F0OSs1NWo2REF4dzRkc1R2NDVG?=
 =?utf-8?B?UDJDZ0ZiK1Q1WVZvUk0wZExZUHBUeGxrWm1LdXd6T1pwelNsYktBSnJMZW9s?=
 =?utf-8?B?a0h6NWppR29FQ2VxVDBPdzFjd0dTdGd4VEVUNmZjS3Y4dUQvTnZzZWdvOHJ6?=
 =?utf-8?B?dUo1dXFYUXNBdndqUy81U3M3dDMzbU9WODd2SFJjaUhKTWRqeDBRZG5mQkg0?=
 =?utf-8?B?SDFCdWNiTSt0eWVkTkJ1a2twTWhHRDJQd0NXODNZWXdjQTN0SWJIcWRIOW9y?=
 =?utf-8?B?WTBnVko4TksvcFl1UHcxMHRSK1NSU0t3WE05ZkJrMGtWNTNTaDZmc2dvY3py?=
 =?utf-8?B?eEJ2bko0bWxCZkJoMytTUnFCalhMcDFrNEM1VzRDbndBaUVjVUsrc2NiT2wv?=
 =?utf-8?B?R203dGFzcmhxRUlFUVVxYkNCK2pCVkdIdjRTT21CMkFPRFhxbnE0N2RHVW9x?=
 =?utf-8?B?bzNtV2NNWUViaGk3WW5CNlJkOGVMaTFzM2QvRFNaUG8vbmJ0aG1GOW4wT0V2?=
 =?utf-8?B?ZXRqRXVUejN0NTZ6TWc5dnpyWWE0dXBNWjJJQnNvcEZ1eUxBN25JQXVxQWZD?=
 =?utf-8?B?ZlQ2WTNvUkhQMTI1OWFpcVkyTCtsblZuOWNmZUsreXExd1hFMFN5Z2pITXpD?=
 =?utf-8?B?amptRjZzd3R0MW1Gb280REVlOU5NckNhS0xhejUzK2JoYXdQNlhsbUFsQ3o1?=
 =?utf-8?B?bUppRE1VZHRSK2RRNXIyK1o3T28vbDFxUE0ycEVLemx1M1BZbWJJZzdTbzVl?=
 =?utf-8?B?RTEzeWtJQmc1NU04UjFsU2F1T3ZGeWQwZk5TY1RwUmpLd05JMFIxQmhVbnRl?=
 =?utf-8?B?UjR0RTVQN3RNbTZFbnVHdWozVmhFcUtoSWdmV0ZmQWtnOXkyY3BZWHJJQVhI?=
 =?utf-8?B?RWR1NC85cGkrYlQ2ei9iczZRcFZhWURNSjVtZkh2ekRFQmRTTFQ4aElvZnFM?=
 =?utf-8?B?UzZsTTlqbmNMMlBNdERRRGcxVkY5c2VaT3N4UndpSkNLRG1PYzN2c3NGVHpD?=
 =?utf-8?B?aENHZHJnZTBmVEtHeWYxMmdSSkQyMjgvcUVjK2ZSS0RpSlVtbFEyV29COTVz?=
 =?utf-8?B?VmVpZU0yVUR2Z0p4aFVvRS9VU1laUzVvVDdCbnY1M25YejF2YkRHcG5DY3dh?=
 =?utf-8?B?TkhSbkUzSzUyTWJyTkNDY1lVTXJGeTdmb0xPRTZ6MFBqaXloYm5neWZUYjEv?=
 =?utf-8?B?S2c1b1BzOEtWWmw3MzBoZDFpSVNRdC9Ua0Z0V2k2b2huZkVYZkdIRzBEQU1M?=
 =?utf-8?B?NnRFNWRlYTJPSlZwRlNYbFM4NVdobTZLYnU1a0VkUngrL3ZudDlxUUpUTDMy?=
 =?utf-8?B?MENWeFIyQll4UnZTRlBOcm03d0dFckF2Z043ejB3Q2xjVGxsUlBVdWxJUFEr?=
 =?utf-8?B?NEhKVi9Janh5U05Cc2JMb3ljYmlpcXV0TzVjbG8vMnhCSVNFU3pWUHJDK3Bs?=
 =?utf-8?B?Z3FHQ0ZPb2hGc08zNmQ0UlhrWTRyMVYrbHM4Q2IvRFo3VTdsUExKYXhhMStr?=
 =?utf-8?B?bk8xY1AzMnlYMlpybFpUa1BaNU5sblVvcEYrdEgzK01LY2ZVU0R4ZzRhQzkv?=
 =?utf-8?B?cjkzS1gxRzhkdXNsenY4UmsxWitEZVltYktBaCs2eWF3ZmdQdXdRNXZFVHEr?=
 =?utf-8?B?eWhxM2ZLUXZlSFEzSU9yRlg1aWdCaCtaby9NUWFmTXBEYThWUDh4VlYrWVdK?=
 =?utf-8?B?TzdkZGlyblZycUpCSGVPanRiV2JHN0Y0L09XTUlaUGpEdks0dFR2QjdYczhJ?=
 =?utf-8?B?V2dGaWlIMHAvM1BzWTVYYXhneFozcGlnQTZ3TlR4VVh3VEdiMnVyNVN4YzlM?=
 =?utf-8?B?d2J1cC9YbklrQ1FNYkdTZGNkSmhwYW4yU0l1NUdJc1JyRytUWXZUby83YWNW?=
 =?utf-8?B?RnRrYmZ1NkxoVG5pbDBFVGdJRWo5QUZFK2V1K0dteTRJYi82ZkplUCtWRGM5?=
 =?utf-8?Q?Erlk140jsYHuUfl3CfTU/OTBF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd57fcc-afa6-45aa-ea7f-08de31bb9c47
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:58:18.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+l0/kHEo6gHhqJ3C+h0FS5qVuz8VytpVEExRtHJrsfDOKbYcTpHKZ5IvM+u+exJA3+V3zb181oa8BTJd8RCQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818

On Tue, Dec 02, 2025 at 03:25:31PM +0900, Koichiro Den wrote:
> On Mon, Dec 01, 2025 at 02:19:55PM -0500, Frank Li wrote:
> > On Sun, Nov 30, 2025 at 01:03:42AM +0900, Koichiro Den wrote:
> > > Add new EPC ops map_inbound() and unmap_inbound() for mapping a subrange
> > > of a BAR into CPU space. These will be implemented by controller drivers
> > > such as DesignWare.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/pci-epc-core.c | 44 +++++++++++++++++++++++++++++
> > >  include/linux/pci-epc.h             | 11 ++++++++
> > >  2 files changed, 55 insertions(+)
> > >
> > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > index ca7f19cc973a..825109e54ba9 100644
> > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > @@ -444,6 +444,50 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
> > >
> > > +/**
> > > + * pci_epc_map_inbound() - map a BAR subrange to the local CPU address
> > > + * @epc: the EPC device on which BAR has to be configured
> > > + * @func_no: the physical endpoint function number in the EPC device
> > > + * @vfunc_no: the virtual endpoint function number in the physical function
> > > + * @epf_bar: the struct epf_bar that contains the BAR information
> > > + * @offset: byte offset from the BAR base selected by the host
> > > + *
> > > + * Invoke to configure the BAR of the endpoint device and map a subrange
> > > + * selected by @offset to a CPU address.
> > > + *
> > > + * Returns 0 on success, -EOPNOTSUPP if unsupported, or a negative errno.
> > > + */
> > > +int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +			struct pci_epf_bar *epf_bar, u64 offset)
> >
> > Supposed need size information?  if BAR's size is 4G,
> >
> > you may just want to map from 0x4000 to 0x5000, not whole offset to end's
> > space.
>
> That sounds reasonable, the interface should accept a size parameter so that it
> is flexible enough to configure arbitrary sub-ranges inside a BAR, instead of
> implicitly using "offset to end of BAR".
>
> For the ntb_transport use_remote_edma=1 testing on R‑Car S4 I only needed at
> most two sub-ranges inside one BAR, so a size parameter was not strictly
> necessary in that setup, but I agree that the current interface looks
> half-baked and not very generic. I'll extend it to take size as well.
>
> >
> > commit message said map into CPU space, where CPU address?
>
> The interface currently requires a pointer to a struct pci_epf_bar instance and
> uses its phys_addr field as the CPU physical base address.
> I'm not fully convinced that using struct pci_epf_bar this way is the cleanest
> approach, so I'm open to better suggestions if you have any.

struct pci_epf_bar already have phys_addr and size information.

pci_epc_set_bars(..., struct pci_epf_bar *epf_bar, size_t num_of_bar)

to set many memory regions to one bar space. when num_of_bar is 1, fallback
to exitting pci_epc_set_bar().

If there are IOMMU in EP system, maybe use IOMMU to map to difference place
is easier.

Frank

>
> Koichiro
>
> >
> > Frank
> > > +{
> > > +	if (!epc || !epc->ops || !epc->ops->map_inbound)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return epc->ops->map_inbound(epc, func_no, vfunc_no, epf_bar, offset);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epc_map_inbound);
> > > +
> > > +/**
> > > + * pci_epc_unmap_inbound() - unmap a previously mapped BAR subrange
> > > + * @epc: the EPC device on which the inbound mapping was programmed
> > > + * @func_no: the physical endpoint function number in the EPC device
> > > + * @vfunc_no: the virtual endpoint function number in the physical function
> > > + * @epf_bar: the struct epf_bar used when the mapping was created
> > > + * @offset: byte offset from the BAR base that was mapped
> > > + *
> > > + * Invoke to remove a BAR subrange mapping created by pci_epc_map_inbound().
> > > + * If the controller has no support, this call is a no-op.
> > > + */
> > > +void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +			   struct pci_epf_bar *epf_bar, u64 offset)
> > > +{
> > > +	if (!epc || !epc->ops || !epc->ops->unmap_inbound)
> > > +		return;
> > > +
> > > +	epc->ops->unmap_inbound(epc, func_no, vfunc_no, epf_bar, offset);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epc_unmap_inbound);
> > > +
> > >  /**
> > >   * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
> > >   * @epc: the EPC device on which the CPU address is to be allocated and mapped
> > > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > > index 4286bfdbfdfa..a5fb91cc2982 100644
> > > --- a/include/linux/pci-epc.h
> > > +++ b/include/linux/pci-epc.h
> > > @@ -71,6 +71,8 @@ struct pci_epc_map {
> > >   *		region
> > >   * @map_addr: ops to map CPU address to PCI address
> > >   * @unmap_addr: ops to unmap CPU address and PCI address
> > > + * @map_inbound: ops to map a subrange inside a BAR to CPU address.
> > > + * @unmap_inbound: ops to unmap a subrange inside a BAR and CPU address.
> > >   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
> > >   *	     capability register
> > >   * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
> > > @@ -99,6 +101,10 @@ struct pci_epc_ops {
> > >  			    phys_addr_t addr, u64 pci_addr, size_t size);
> > >  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  			      phys_addr_t addr);
> > > +	int	(*map_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +			       struct pci_epf_bar *epf_bar, u64 offset);
> > > +	void	(*unmap_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +				 struct pci_epf_bar *epf_bar, u64 offset);
> > >  	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  			   u8 nr_irqs);
> > >  	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> > > @@ -286,6 +292,11 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  		     u64 pci_addr, size_t size);
> > >  void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  			phys_addr_t phys_addr);
> > > +
> > > +int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +			struct pci_epf_bar *epf_bar, u64 offset);
> > > +void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +			   struct pci_epf_bar *epf_bar, u64 offset);
> > >  int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
> > >  int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> > >  int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
> > > --
> > > 2.48.1
> > >

