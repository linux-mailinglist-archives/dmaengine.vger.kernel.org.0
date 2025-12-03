Return-Path: <dmaengine+bounces-7486-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971EEC9F3FE
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 15:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8023A751E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3FB28750A;
	Wed,  3 Dec 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FziDIaQp"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010059.outbound.protection.outlook.com [52.101.228.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B182F49FD;
	Wed,  3 Dec 2025 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764771149; cv=fail; b=iQLYJzCxXFKUuYEEjbOIR4uuaW0jnbr8E+ucvDhX9dYxhjxAjiWEEceTI6CMcbrL4kfoPGKl8h1uKo8Pb0RV8jtEPcdQygGPVwHs3iyryONXYcqDgl5V0+/VUDK8W0BZgK1TYrOCvvExgNW1yippstBMod85BWBPyU7XJuuIWnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764771149; c=relaxed/simple;
	bh=dv9/6qh5FIN00UkYEvvL/PoXaBjLtfYgXbJHY8n7UUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=agPS3bDftmv8jJfZqlNnch0/G1e9/avm9KDisrvvjZiK0NyZBfsRlW472GveIwj6VW48MfZRj5WmQuFLnMDMEdmPtqWLzRwHNqrYYXnc7mXexG6nONulMHoBUe24B5EJcY2d4oQSPoSkRwAXCIsegXe/Pp1w6Xztr6aagfO4VwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FziDIaQp; arc=fail smtp.client-ip=52.101.228.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFW7cMdhBHjcG8NpNBo3tj0Z0DaWz4uQjMlXBzlrDjD6a/hf/Kh6cT6u8MXm0UPXa1Gns6UTXuAh8i0nAMfS4hyos+5+uFAdfq5FuSzt0ix2nMj5IrgDa78vQx3HL39U91cCEWkMKGwean849Rn4x1nfq2B6dqc7gdyxzkTNb5hOcDiTkM76mk+K10f34IXzoYk3AqrvMtrm5dR5hu0yfx4rfZ/2AJY1gTE8AmO7jmhQhyXh0r2au9/lzQpROaX+LIF2ae30B8fZNW7THJNHKAbgWKLAOaXbEuyOJhjgvHOh8VUBzfQXPuSIVQUsi8vH4+L96+6XGpd9+23ElhVjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADRCO5pVXIF/KZi/li948nnXqpRkl761RZR3dLxA7yI=;
 b=WoShPFDFbD7Cs4gElvNSjwCr7U4dw5woWMe060M1NQuFRH+4qF6Tt08oH0Ievy/R+fqMIpOkpqZs88Kdv6hN8GUEu1F1waKXQm6BhQG5qkierFc8YzpbUBxPEJz0iYHxHjC/x39w3aVaR9n3JmsrfEE5M6faPPidpT3CX+pimorE+KtSP6Z68gimMYVEXzzEIrBueQSrRjGzvB+vY/tgjmjvoWv0VmszdnRnVRIKHdBCClnvOZm6FzfD9caEa0gRxDAMaEDNS4Tsc22+EkU5YUO8RwBaPJmYWLyjBsHuaayRd8yobmDfxbaWLnE6oI+YTXejGnobd77xx3n9uCm94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADRCO5pVXIF/KZi/li948nnXqpRkl761RZR3dLxA7yI=;
 b=FziDIaQpzhDTkP5Thx+fuIaGEdj3AdwiQcFyUFeaZINJvKotq86+fP9UPa2A3kKHqlC8uYjpqZ1X9GoCuc0WL9BnpD8AVEM6dmHCejNgm2Ke9MlM875EH8nHW5oz3oDnxkBPOE07QDLyZ/4I37EqMZi/FdNp2mp3eib77DlgDGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB5208.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:30e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:12:23 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:12:22 +0000
Date: Wed, 3 Dec 2025 23:12:20 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 04/27] PCI: endpoint: Add inbound mapping ops to
 EPC core
Message-ID: <jphfjfyr6ok76ljpf45ufxnzhicd5pcebu2t2jz35qpw5il6ai@ztf25y25fasf>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-5-den@valinux.co.jp>
 <aS3qW0LX/ueo2ZP6@lizhi-Precision-Tower-5810>
 <dqqewhnmesylgqmj7vohhwxs3aqemysgkymayst4p24yhkgszv@prztzziimnx5>
 <aS8MkMlNOaLANauE@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aS8MkMlNOaLANauE@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: eef43d79-9ff8-4879-90db-08de3275f9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVloQXhCaFBYLzc5c1l5L3dzOEp2dGRvR1NnNVkwUDFOdmw0bnh0dnd0MnRU?=
 =?utf-8?B?MFBUTHI0SlR1RjFGUVdaQWJCREUzeTRscy9OcjEyZ2dOWnB2VXZPSkFLSWtx?=
 =?utf-8?B?UmNicW41czhncE8zbE92N2tGVUhtM2ZkanF2enNBbmEyVHIzWjNrOEp1MHlV?=
 =?utf-8?B?K3ZQamJqWkNWcDVIa0hMSFFqTHd6THM2NXY3Q3g4cWdpU2J3Uk5NOWd0QkpI?=
 =?utf-8?B?elhRL2xaT0dKTFNsMW1XbjdiaFgrVzg4Mi9UcHJlTW1kZjdnaUc5OW9oMWUv?=
 =?utf-8?B?VGZ2K2QxYjIreStxbEM0VG5HZnRQSUhLWU5KcXRWR09mRXo0LzRXVituTUNq?=
 =?utf-8?B?dTF6TTQycXFnRzFvLzRQSnZoTmJUTXZ2WGNoMm9lc0pxMWs2QmJXek5XbDlq?=
 =?utf-8?B?eU9oUEJxS2JZMk5Na1JzLzdjeEJ2eTN2L1JZaDJHRENxSHRmWkhQL3lHTEpi?=
 =?utf-8?B?Y0VKYVB2aGZieDgydDZBbjRqWFNiU2t5aGNvTUJJYU5xMkZVSUxKd1Y0T2t5?=
 =?utf-8?B?V1YwdkVVZmg5MVhtNkxJK1d4UWlIMFdDZy93WHpOU0lxK2I2YVBvZ3VjWWxs?=
 =?utf-8?B?WkJTc2M5VzZib2RYUHlLMThmSFB5Z0tPRTZrb3ZzcW50OTNQUDQrem5sNnA2?=
 =?utf-8?B?Q21xTGhSU25rVFdMRHFyMUxWYm1QRkJQYTl3VWszZGozU3lrZlN2dW9mRUhU?=
 =?utf-8?B?VldQcFNRWFBVbVoraGdDQVM0L3JTNjg3MWxLbTAyNmtLYUNkUEFEZnpOenM1?=
 =?utf-8?B?RG53ZEI0MXhYODkzaGlmUW16U3pFVi9oNlVJQ3RMeHR2UVN6akdkUzFsdU9r?=
 =?utf-8?B?blNZK0FYUDZ1aGN4aEhoS2tOS2hXNXdDOFYwdUlvTGV1N2RwWXRGakYzZmVa?=
 =?utf-8?B?RnlvdzJ4WmN1T05xb09kNFIzdXcvTkt2UStWaWlNV3o4SHRiWXo4YjZDV3pl?=
 =?utf-8?B?RmNoN210WEE3Z3JuYVNCN2lQYTdRS2VscEtFZncyQVB6MjdVU01vMXpzUWNW?=
 =?utf-8?B?YlNTTzgyMVRLR01xOTFMU1d5aVJNOHdJNWtaYXp2Wmx2WWh0bnZLMldhTXI5?=
 =?utf-8?B?akZ6azZ5RzJlMGlhZUFjWC9MQ2d6Y25wd0NZM2hHV0NYRk9zZmdjRXJEdkQ1?=
 =?utf-8?B?elp3NisrVDBpSmt4eGN0NlY4L01rOEhtc2NBZzRPZDZjK1FqOUhxUjdoQm93?=
 =?utf-8?B?K0JSck1YZGo3a2JSdTJ5K3k5dkxkcUV5YlNQZ0xGQjEyVU1xd0RzMzFrM09I?=
 =?utf-8?B?b1NjTFFwbHhOeFNkTWM5Q004czJncXFRT3hXNDBHN0gzbVI0YWphenNwUHEz?=
 =?utf-8?B?dVlabTVyZ05oc2kxZ0MwcUQ3Y0lKeWE0dzhPWFF6RGtZMVV4ekh5VXhsYk4y?=
 =?utf-8?B?L281aUhCN3BXeHE4ekthTVp2Q09QSkg3VjZ6aW1FVEtCOVoxVm0wSTM4SkVB?=
 =?utf-8?B?N3lXL1lpWW1mNzlLZk9zNlc1QmZ5c0xBVVp5c0dIb051MlIvNzJMb1d1Vy9W?=
 =?utf-8?B?SUQxTDVyT3VCOGZTUDc5bUprbHhYcWdBNXl1U2hPMXJRNFkwT3FYQVpYQ0NE?=
 =?utf-8?B?bzFBUTh6VmJTWHpOb0o2d0liQlVLOFpGZTJ6WmkwK1NKVlVCK1lkcWVHRHFL?=
 =?utf-8?B?TFZNcXpoQWtCR0NLZXptTXkxQlJiY3Zla1Q4VnhnaFRrQ1NLQ3VCc2RuVGxK?=
 =?utf-8?B?NGdSZG5xTkFkNm9jdlJZTzc0TkJNWWI1bURwSk05dkNBdTQ3VUZLSE1DZzdL?=
 =?utf-8?B?Z1dINER5akJpcWwvSGRlL0EvZ0RXWU5VL2tObi91b2tVaGlzQTlPOEhVVzdn?=
 =?utf-8?B?bUhuUHVVZ3lTVnE1YzFsZHdnSHVsbzIvZzFzQmlCUlByUU11bThJL0xiRlEr?=
 =?utf-8?B?eWUyOVlGSk96S3dBMXdLZjREeUNiNEpvaFE4cmNMdWdZVWptUnVBdGxWM3Jk?=
 =?utf-8?Q?2l5PvGAdQaoXlOEFpcrBzFzAk0GOPVsc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVkyRzRKQkU3bSt0WWNab3ZPK2htTHU0a3NySGlnVE1MVXdDSTFiUFo1VERy?=
 =?utf-8?B?L1BNNjhFZTdkN2tMcXFpNzBVMlQ5VzlyRU01SG5QWWU4ZHVuR3c4OHp5T0c5?=
 =?utf-8?B?NFlMTzhOZklXc2JIemxiYkhYcitSR1NubWZ4N1p1YTByWllsdWpjMUhCUmhE?=
 =?utf-8?B?ZDVoUGptWnhlVWpkQStSU1Ayb2djM3Vqc3BLQzN3R1lZZXE4LytST2diL2tl?=
 =?utf-8?B?TXp2alRVMVI2YWZZZXdZaTlNVHpsc3ZWdEdNQ0hyWkJkVFFKaGcrdWd3VnFE?=
 =?utf-8?B?dmdEL2NnOG5pMFdidytSNVo3V0ZtSmE2Q0hEby9KLzNlUEhZZnU3RVk1WXM4?=
 =?utf-8?B?RE9CVFdER2xuQkFuZllSYUZpN1diOXd0RGxETXE5c1o3VkI5V0hOYVgwdnhk?=
 =?utf-8?B?OHRhSWdTbTREZ2JLSnJCakZ6VW56elIyeGVHNkVHb25OMnJxNEdEeTNzRDVR?=
 =?utf-8?B?bUp2aG1ZNmRvUm9qc1l5MW0xK0RlWDF0a2dDVEtZTmRkYW9VeHVhWGowb2dI?=
 =?utf-8?B?QXNFWitveDE3MWJDc2RsSjNFdTZkVFhCZUNKOEZzd0lXajkvTDJBR3EzNGhw?=
 =?utf-8?B?cmVXYmRMaVk4U1JXL0VqNGZlbi9sQnBJMWM5clVITUdSRlNrNHZDaHdKNkM5?=
 =?utf-8?B?c21QaXVrSktTMlBpVkNVQzVQTmdhK05GMTI0eVJZMjIxd3JwWUdHNUZFdTN0?=
 =?utf-8?B?MTd5VDNHMTMvYitvYXJaWkt6bkFqOFplcWhZVnF5VGVmUFI0THBSQVdUdExT?=
 =?utf-8?B?YXVvUG9WSVVIaVg4QkpZSDFpaUczRUJlajhBZVg5MXJBUkwvam9NbUxNSEZH?=
 =?utf-8?B?SmRIQThmSlFDRTNKeFFyZmQ4aWRnSit5MjZuKzRRbVJCVFlnWVdqRlI2VlNx?=
 =?utf-8?B?NWF0VTlGdENNeWFLb00rOFBON1pCV1dtRGtaOTl4cGNhUlpDcTRuS1l2N0o0?=
 =?utf-8?B?NUkrblFHV3E0NXUxbWdRcWlwVkRpZjg0NmY5Sm9KRDNzUFlTUk11RGJSTFF0?=
 =?utf-8?B?WHZsYWw5QmFGWnQ3VE9JV2VKV2tEMWNQYlVNcFVQNXhMbnhKTWE1K0tzeHJQ?=
 =?utf-8?B?dkVJYkVveXIrYlZrbktFMFpZZ1pOUG92TEIrQ2tKS0xYOUFsRmFGTHVzVTZG?=
 =?utf-8?B?RWlRZzBsRm0rY0ZmalVxR2hadHAvOVNDQWF5c3FPUTRtdVJEQ2NhOHVUVkRx?=
 =?utf-8?B?V2lOeVdjdTQ5dXVjd0sxbDA1a0IwR2R3eUlGTlAwalluM0ludGtjeDhxdTZT?=
 =?utf-8?B?L3NEeDlwYmU2VkhIelh2V3RuRGpMc1ZNSDZjRWlIc3IxbVVXbjNYUXhvbUxp?=
 =?utf-8?B?NU50R2UyVGtIYnp6c0o1Z255ajRZOHc4VFhxbmdwb1BzSUREc2N4TUxwWkJZ?=
 =?utf-8?B?cXliSkpQTzRQeGQ4aTlPZTVqOUZqNHoxcDBqVHdYNzhtRllyOW1UVVVkSUNh?=
 =?utf-8?B?eXVFTnRFT1h6bStMWm5xVkUxeHBjYm1nQjdJNWRYdWdFWnJoMFIyNEdXa21M?=
 =?utf-8?B?VDhyY2l2RDBON0o5NXpjTEgyRDRkTlZMbE9jZFJwWGtPNnFjODdZcExkdW92?=
 =?utf-8?B?eWl3YS9ZNktnOWkzdHEvc1p5VTJpNWFLMGJpaEhGcmFSL1MvQUZLU2tQZldr?=
 =?utf-8?B?dGJOaUpjUGU1OUx6M1Z3REJMMjh0QXdJMU9paVdoUmMwRHIxMUZNa01aU3Vi?=
 =?utf-8?B?RlY5MHFRNWpCVTNKK0Q1VXE2WDJGczlJeit4RE5mQlg5RkxZY3kvZHpCa2lW?=
 =?utf-8?B?M1JYZ2hBNGZaOWF1U3pybyszWko0QzBkUnZLUXNnaGxQOGZ0Z095TG9TVUhS?=
 =?utf-8?B?UDFobFhUdGpkMzZaZ2d6TUpJRGRQMnVNTG5aMGprc3YyM3BMYjB5SVl5eXU0?=
 =?utf-8?B?cGhVUHNDdVdQb1RObmpYVm1KTi94aTdoUU9mWXNyS05NRXJnZ01TMmx6b1NX?=
 =?utf-8?B?Uko0VGdINnIxMVBKMTJyZm02RHQ2aE5nbFUzVDhrWlZXRWZ6OXZPc29nQ1RR?=
 =?utf-8?B?YnNWVzJRUlF3SE44V010Vkw2alQwK1BWRXdYdUl5QWFNeU5JOUhXb1YrK2l6?=
 =?utf-8?B?NDdWRXpDRjI1bTk2bmJLZS9pemNVUjlGeWpnWGJJTkVhZThGbDBZdHN6MC96?=
 =?utf-8?B?YkxLdzZkVGg2YWkxSzN3cTVOME1JR3V0ZmdDZDFjODB3RmlvWFAwRHlaOUMw?=
 =?utf-8?Q?D2vmfBQ5g47hHN8gU2IPVnY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: eef43d79-9ff8-4879-90db-08de3275f9ff
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 14:12:22.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgK6EkaA6F/mGgr9Za4XTGOHIzz4wcoxUmnmgyGa4bP5YNeUhMakje64bbZ0m8INk/zQSgqgWRjqEUuz6doWEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5208

On Tue, Dec 02, 2025 at 10:58:08AM -0500, Frank Li wrote:
> On Tue, Dec 02, 2025 at 03:25:31PM +0900, Koichiro Den wrote:
> > On Mon, Dec 01, 2025 at 02:19:55PM -0500, Frank Li wrote:
> > > On Sun, Nov 30, 2025 at 01:03:42AM +0900, Koichiro Den wrote:
> > > > Add new EPC ops map_inbound() and unmap_inbound() for mapping a subrange
> > > > of a BAR into CPU space. These will be implemented by controller drivers
> > > > such as DesignWare.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/pci/endpoint/pci-epc-core.c | 44 +++++++++++++++++++++++++++++
> > > >  include/linux/pci-epc.h             | 11 ++++++++
> > > >  2 files changed, 55 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > > index ca7f19cc973a..825109e54ba9 100644
> > > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > > @@ -444,6 +444,50 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
> > > >
> > > > +/**
> > > > + * pci_epc_map_inbound() - map a BAR subrange to the local CPU address
> > > > + * @epc: the EPC device on which BAR has to be configured
> > > > + * @func_no: the physical endpoint function number in the EPC device
> > > > + * @vfunc_no: the virtual endpoint function number in the physical function
> > > > + * @epf_bar: the struct epf_bar that contains the BAR information
> > > > + * @offset: byte offset from the BAR base selected by the host
> > > > + *
> > > > + * Invoke to configure the BAR of the endpoint device and map a subrange
> > > > + * selected by @offset to a CPU address.
> > > > + *
> > > > + * Returns 0 on success, -EOPNOTSUPP if unsupported, or a negative errno.
> > > > + */
> > > > +int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > +			struct pci_epf_bar *epf_bar, u64 offset)
> > >
> > > Supposed need size information?  if BAR's size is 4G,
> > >
> > > you may just want to map from 0x4000 to 0x5000, not whole offset to end's
> > > space.
> >
> > That sounds reasonable, the interface should accept a size parameter so that it
> > is flexible enough to configure arbitrary sub-ranges inside a BAR, instead of
> > implicitly using "offset to end of BAR".
> >
> > For the ntb_transport use_remote_edma=1 testing on R‑Car S4 I only needed at
> > most two sub-ranges inside one BAR, so a size parameter was not strictly
> > necessary in that setup, but I agree that the current interface looks
> > half-baked and not very generic. I'll extend it to take size as well.
> >
> > >
> > > commit message said map into CPU space, where CPU address?
> >
> > The interface currently requires a pointer to a struct pci_epf_bar instance and
> > uses its phys_addr field as the CPU physical base address.
> > I'm not fully convinced that using struct pci_epf_bar this way is the cleanest
> > approach, so I'm open to better suggestions if you have any.
> 
> struct pci_epf_bar already have phys_addr and size information.
> 
> pci_epc_set_bars(..., struct pci_epf_bar *epf_bar, size_t num_of_bar)
> 
> to set many memory regions to one bar space. when num_of_bar is 1, fallback
> to exitting pci_epc_set_bar().

My concern was that reusing struct pci_epf_bar, which represents an entire
BAR (starting at offset 0), for the new pci_epc_map_inbound(), might feel
semantically a bit unclean.

pci_epc_set_bars() idea sounds useful for some scenarios, thank you for the
suggestion. I also think it's not uncommon to want to add Address Match
Mode sub-range mappings incrementally, rather than configuring all ranges
in one shot through pci_epc_set_bars().

> 
> If there are IOMMU in EP system, maybe use IOMMU to map to difference place
> is easier.

That certainly makes sense, while personally I would prefer a single, more
generic and intuitive interface that does not depend on the presence of an
IOMMU.

Thank you for the review,
Koichiro

> 
> Frank
> 
> >
> > Koichiro
> >
> > >
> > > Frank
> > > > +{
> > > > +	if (!epc || !epc->ops || !epc->ops->map_inbound)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	return epc->ops->map_inbound(epc, func_no, vfunc_no, epf_bar, offset);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_epc_map_inbound);
> > > > +
> > > > +/**
> > > > + * pci_epc_unmap_inbound() - unmap a previously mapped BAR subrange
> > > > + * @epc: the EPC device on which the inbound mapping was programmed
> > > > + * @func_no: the physical endpoint function number in the EPC device
> > > > + * @vfunc_no: the virtual endpoint function number in the physical function
> > > > + * @epf_bar: the struct epf_bar used when the mapping was created
> > > > + * @offset: byte offset from the BAR base that was mapped
> > > > + *
> > > > + * Invoke to remove a BAR subrange mapping created by pci_epc_map_inbound().
> > > > + * If the controller has no support, this call is a no-op.
> > > > + */
> > > > +void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > +			   struct pci_epf_bar *epf_bar, u64 offset)
> > > > +{
> > > > +	if (!epc || !epc->ops || !epc->ops->unmap_inbound)
> > > > +		return;
> > > > +
> > > > +	epc->ops->unmap_inbound(epc, func_no, vfunc_no, epf_bar, offset);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_epc_unmap_inbound);
> > > > +
> > > >  /**
> > > >   * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
> > > >   * @epc: the EPC device on which the CPU address is to be allocated and mapped
> > > > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > > > index 4286bfdbfdfa..a5fb91cc2982 100644
> > > > --- a/include/linux/pci-epc.h
> > > > +++ b/include/linux/pci-epc.h
> > > > @@ -71,6 +71,8 @@ struct pci_epc_map {
> > > >   *		region
> > > >   * @map_addr: ops to map CPU address to PCI address
> > > >   * @unmap_addr: ops to unmap CPU address and PCI address
> > > > + * @map_inbound: ops to map a subrange inside a BAR to CPU address.
> > > > + * @unmap_inbound: ops to unmap a subrange inside a BAR and CPU address.
> > > >   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
> > > >   *	     capability register
> > > >   * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
> > > > @@ -99,6 +101,10 @@ struct pci_epc_ops {
> > > >  			    phys_addr_t addr, u64 pci_addr, size_t size);
> > > >  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > >  			      phys_addr_t addr);
> > > > +	int	(*map_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > +			       struct pci_epf_bar *epf_bar, u64 offset);
> > > > +	void	(*unmap_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > +				 struct pci_epf_bar *epf_bar, u64 offset);
> > > >  	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > >  			   u8 nr_irqs);
> > > >  	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> > > > @@ -286,6 +292,11 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > >  		     u64 pci_addr, size_t size);
> > > >  void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > >  			phys_addr_t phys_addr);
> > > > +
> > > > +int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > +			struct pci_epf_bar *epf_bar, u64 offset);
> > > > +void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > +			   struct pci_epf_bar *epf_bar, u64 offset);
> > > >  int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
> > > >  int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> > > >  int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
> > > > --
> > > > 2.48.1
> > > >

