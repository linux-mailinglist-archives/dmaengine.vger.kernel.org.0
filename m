Return-Path: <dmaengine+bounces-7031-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BF9C19208
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2AE1C874B6
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395B3168E0;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v/x7yNpa"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243A15855E;
	Wed, 29 Oct 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727038; cv=fail; b=bkfvflkc1J/K0/irR1ZCcW2UtnTqVKR4sYdwlWitLnU1nTDtYigyMnxlkxQs18cvrEu/WB9J3IT/+3wkBHYAiGsoiwVJoUwNPG8QrgyiTqp4JCN9sN3vP7K3MzSMFiOFzkJF8ppYVn7mumABVScw52dGDxqWnLShAgPXNdwCLT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727038; c=relaxed/simple;
	bh=q27CHA9iMRs6C1CF0G1vDYxwZw0KebOOcv+jhqYzlFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PsW35WHGyIShabij+omxmkiXukprl82BVSQMKHbyzZ2ehWKAudloKiOLyJSrZuV0Jgr+oIRLs9Qbb75/76IiD1X4A6P+EMp72aNtb0/yH96HRcFHvIJxLYRwwIa/lvzuzQGGyWLIq4sXs68yDNpdoTMGVmHesv++vqm+CmdNY+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v/x7yNpa; arc=fail smtp.client-ip=40.107.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+abIyqc1PvMe1oPpouyLGljnOKnM93DFu+3eK/+BOcMnzUukvDlEjfZUkIyD4mW3KWZq8BKRbTJEQ+HvuqW35dYvuPMfGZnknfMVohedcjb9vVeiSbrIzjEg5NWb/XpNyVnh0dxDYWtR01ImGCD4acISDCBLlYpG8Eglic8oR9vX0wdXqcUqb1C3jRDpHfnGped5d06ftXcSgiu/JkQolcq2LXu9e0JJmLOrJuZ2WAV85R9mbHitO8ZKCESUoTVt133OTXb1I9H4GJERwxcqnNO5NeaA2XaFrQi+b6l6JAt3y3pw09jd5wSfqB2DuTYBhDMTJ6Mt3knqz2m/pXMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES3JxrjMEBoSBM1A0VhvPIr9U4F7oZKKJstmhlueDSc=;
 b=G9XjtPMzo/dg4aAhbLNFsTSuP3RQxoC1PG1lGIDPk4pKV4jiWWs2ajDxNErc/+uRfAgIRkxye37Pcgx95Uf5P4uJIloVF1aTa2XCLiXZVwgym405Mu6zytdYrQ5JSXnoIUvBsfeTT/shjCaATu1REMkR0cIS24KW1KiYYiAPy7Fh/XHIl3S8WbNc5wbe+pSTy2Y6Ldledxh/SxIYnSxHWD3+JvuK2C8jlT8rjLf/nEewViwwtm7wF7EdUF+JZdjcxAQ2odhFMdJCMI+n9fwcxmaORDx/XY/nZerL27gTinr3Gx3pX/inS1fiuJZsjYgJsqwGplUWhD9T1v9aQPuaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES3JxrjMEBoSBM1A0VhvPIr9U4F7oZKKJstmhlueDSc=;
 b=v/x7yNpaJkbJIRGceRfQjEA6YEuci/K099yBBcx/nC+dIsmbmFUBCdh/iEScEERdfiIl0vABPi/owTAT+h8ubGaBW9OaZ97Z9gjuuBqsuminaEzhTlsu+ed2n43GrBdyHm9wkmZyiVOfKB2w0sqXdQzBhr/WKjHrIIeLXedm3rw=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:37:13 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 08:37:13 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v5 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Topic: [PATCH v5 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Index: AQHcR/4VEKe+V716ek6rhtuCZpyLK7TXjWqAgAFAhSA=
Date: Wed, 29 Oct 2025 08:37:13 +0000
Message-ID:
 <SA1PR12MB8120885A5A0FA91732488D1B95FAA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251028112858.9930-1-devendra.verma@amd.com>
 <20251028112858.9930-2-devendra.verma@amd.com>
 <a550db5b-a36d-982c-0783-134abdeb1f70@linux.intel.com>
In-Reply-To: <a550db5b-a36d-982c-0783-134abdeb1f70@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T08:35:20.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|DS7PR12MB9525:EE_
x-ms-office365-filtering-correlation-id: 26fc9032-9c77-4369-3693-08de16c65c20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AWu47iUfRSba5gA3O34t+B3YvApmVBoZCvsoUA8doxWuH9TszpbDieSx6I?=
 =?iso-8859-1?Q?QG2Rgp9qpj3Eif1STQUywt8Lz8you0eNMkm5cHqgfFzrMJDgbX133OZPPt?=
 =?iso-8859-1?Q?jhjWm6pPSgGdx4JhinfWCohmDgTdpnhGY+nZvM8564VLI/DtJs94mHIIs4?=
 =?iso-8859-1?Q?iYa12bhKzfplMQh4SQzD9XqC0qs+1oUfLH5m3Pn3ZM2EdAHKBDVjcxUGlV?=
 =?iso-8859-1?Q?zC+YDp3uExlzNe6h8bw6jckc+njSWAkiw82S7x3awS644kwlkVfjED/5Rw?=
 =?iso-8859-1?Q?N9hLRe/9htX4T6sfikyAkaoS7WHZQlsBVN4fP5S6sAx35Puxjy/54iakVX?=
 =?iso-8859-1?Q?LvQ2le/tYd+q5WbUKZ6hyNZahNrvskcv1Sq2tI8PNSEACo5R3bgpxR5AqZ?=
 =?iso-8859-1?Q?7V8y3Q78q2fi33c3Wn1Z66Fe1RagFuZJ+1qCjCQ1Wbym6lxm9j8sIBRLWS?=
 =?iso-8859-1?Q?OaHvlN4Pt/GAXZWSClN1b6xodSZyQb5Zh0JvyXoG8xqgHqfbcN6TU2dhIU?=
 =?iso-8859-1?Q?LoGqawlwQMx/GqGU5rdQV4zxm/ayHYLHC0a/ZXTJXAtEDJKVT1X2L2um4x?=
 =?iso-8859-1?Q?AvBIKW6X9NABsJrHq5mGyb0rC4MAyG4QMPYHT6mB3BCvtOg0RiP1O2WlMr?=
 =?iso-8859-1?Q?6zIP9XB4bFwK4/U9qORygjZ0kXHgJhDM7SNtyDhkfFFpwR9CWD05ITWCTL?=
 =?iso-8859-1?Q?dSsGVQqLPXIIqzNxlMyBpuS+xqiKng/x6SeXt6wfdaHYd6DkLXReQB1sti?=
 =?iso-8859-1?Q?z3CgNovEZooqRM1MgucUbjx9FBxB8Xl0t2J3DYPv1HC2vs8TfLt0MuUyKi?=
 =?iso-8859-1?Q?1MKpFmS06Nmj/GApXd48OoLQ/zBpG6GXKIy+Nl/zXTs1CHhaFVdzIRf7W9?=
 =?iso-8859-1?Q?RQzCMP85WcHJtdClUsJajxPmYirpLMoCWZjw4rluvTIMzVhFCcT7Gc55qy?=
 =?iso-8859-1?Q?2onQ0WohM2sAK72bwq09k/k9r9oPN1LQ6HdXLr64Nb7kGCt9E8+EzNWVTl?=
 =?iso-8859-1?Q?nEUFVwelPqxAKUW1VehTd02t95hbiobIhvmKhg+sEVHTqL0Iw1IzAKU+ac?=
 =?iso-8859-1?Q?2+vLVDYWmPaXLPY7NgUrz/senzrMxenKdmWrj6Nu4sHR1AYi6BShUGO0is?=
 =?iso-8859-1?Q?IsYFw3LAdbeIeqrOyOlxtkBJttornNKzMlM+NhuRtt7xbq+dg4dXSXCDS0?=
 =?iso-8859-1?Q?HdanIUNbOpCURnNahwNVomoiCCNQQEtD8XHh1J2ZCYKISu1gLB2eNvVFae?=
 =?iso-8859-1?Q?HoNW2iJ4v7y8lsaAXfzXlw6+Ksb1WKS9tvCe94XKR60pum62MIjigKG9WM?=
 =?iso-8859-1?Q?5VVHdY3KpR+o+RAzhp8D5WU21yr8NCNXjluAyTD3OKThNJJ9MG2AZtz56G?=
 =?iso-8859-1?Q?DlSfXu2lxebW00S3F+w0iPC/Tux17hS3o3XKDwm1NXl0Rf9wM751WvuXmt?=
 =?iso-8859-1?Q?CJdyGIZcZdYERceZpc7+Map2G8M+Log6iVbCPqLXtfmEjm6TJ2J4FjxS6D?=
 =?iso-8859-1?Q?y0C6dJUq0KhRSmzEH+Rhggy3DiOBjkDpt00lI3/RmQZ21757ynLVHSC0Y3?=
 =?iso-8859-1?Q?2jF/J6AYkG2st41QDMaGJTmORppa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1yMyHxn1xGrfY4xNBedEimqr5lFQDmJXcSfxjPstoSnFZwP9+kNmW2dR+a?=
 =?iso-8859-1?Q?7lIlHv+MgHVze6CcQN4Bn9KJTkVb21rDcWx1j9uibtNJbKAvmKdcpxvvgU?=
 =?iso-8859-1?Q?4Xdg5I6tjDGlTGgYxL0B5HP0sskBTu2PNWqt8WOY6iu7jc4fG4Ni4717uT?=
 =?iso-8859-1?Q?HgPqNlMPAzVOHxilo661e02FWIynhcP0bxbvnZd76iQNcKE6G3v8Kux+Op?=
 =?iso-8859-1?Q?RNFh/nGWgY4Xs/F8w5BoemPStGwtnHGpZkl7i4f/uGdpk6fsgfzsTYxxS3?=
 =?iso-8859-1?Q?fyzfM/Nk3fATpufyP6BbWCGVL2pj40vQZb7RjCjLQXeQxO0cFZMXJrDzLr?=
 =?iso-8859-1?Q?yExD9fEvKAFg6LUYChXiQI+Zyv785MUe2Gn16hlVtqHnkdYnJoff4Zy6nZ?=
 =?iso-8859-1?Q?Pdfq156bU5iyvVEIKOK7oB2oX7KMdJpK3qi68Z1RT9GrtcZTOuR7JkLAs8?=
 =?iso-8859-1?Q?V1xsMehVN1Am+mGyztz9UwA6ZsCbFTICItHnfVIc0yirYYHUIBrbGAOHe1?=
 =?iso-8859-1?Q?g/5dsf9rnHQUpcTDwV0YcxqBuTunTm1Tx3/3vLwHri5xcL2q+QMUD+DmDq?=
 =?iso-8859-1?Q?GwvTel4r6QYIfXPLSPfpQzy99SoFC46hWPtLWvNk5YCnWNFoKw/i520OaX?=
 =?iso-8859-1?Q?tT1ioGNMPym+SXgx53lfNZzC3j/aL04dy9rBgoYAaycg9rZYBuJWoTS1AG?=
 =?iso-8859-1?Q?I1/q1UVf/l+oIX+i/nWTYNWgVdeuQuiShUEOoOFiLw3d1I5haI+onxD30g?=
 =?iso-8859-1?Q?CwAiRc6Nr06x41wNhFtwppAtHjLxA4/NMVcHTUMfk5Lt/73Sl+FFJVxYLN?=
 =?iso-8859-1?Q?sqQ88DQgUpA6YF74dPYqhkgTlZcKlGuE8mXSE+4oyJznPScKMHtTr92+m4?=
 =?iso-8859-1?Q?XlknVi6YlgnDICVMv83LtYODXraa9LIw3EFJ8VSQSXSBHxeKPqec+7fnD5?=
 =?iso-8859-1?Q?MKuyI1xcfXU40KYGY7KeiJvLXFMjpEmSPwXiVqEvLW6bkBRhu4z5Zg4PHl?=
 =?iso-8859-1?Q?4Exksx1q+xTcChAGrgKTqaNKY7RCE06H53F6i99GVNa3zGFDdYBXk+Df8T?=
 =?iso-8859-1?Q?CuOCm/1yRTxG4oKVaOTuYyvSpR8lQ0ncXvm95yJbyX2k3eCwThf2IALFWL?=
 =?iso-8859-1?Q?4S4cXVA8cs+QNqqizZBGCcdtMSRmyTXnq0UbKcGXEdREPzqmWvYwaCrhxZ?=
 =?iso-8859-1?Q?8umuDz/D06p5HDaLWN4Vxd9llYiZP1V2x3jNiF7AEIA51gJypWySlioVaR?=
 =?iso-8859-1?Q?u56c6ymcSqcvHbWJ8axmPWTDSQMZ9ipXFYR6b48ZJ1aDSx0qH5Nnrwjvnh?=
 =?iso-8859-1?Q?AL+pRlamYjwRnsWM+kXRhtc1iaHOSQGjnt6Wk3Vn3dwbw2TIkpiIJaDs3x?=
 =?iso-8859-1?Q?sbdVDtVcrUNHcGJys6udeN+8/t4kAQOebX+BLMutEesbLQ23i+LEP6m4fT?=
 =?iso-8859-1?Q?3ZCKUxxgjjixoS5AZt+oWrwvZq61DlpgqNj2VJABLWrINYOoR5COZKKiGt?=
 =?iso-8859-1?Q?Pw4brTacSFYsQYbje9U9H7xnWtEK4b4qkutBfw8X7u2Azw8/Ax/fkHCH+S?=
 =?iso-8859-1?Q?hc1L9ON83I06GL1JMAKjfGohqBlTViIiiFIw/eoCmuS+S5pHG+KDqRxgwO?=
 =?iso-8859-1?Q?b3ORaSxcejEDU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fc9032-9c77-4369-3693-08de16c65c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 08:37:13.7847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWiTFE6zfEEiRVtkYH3n84PWDxU9Pst9D1FKlnSxg3ag/mnNpgaY3flghLHjEdbvvWqGT0NnmZocAl2az9Ycjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you for the inputs Ilpo.
Please check my response inline.

Regards,
Devendra

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Tuesday, October 28, 2025 6:58 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; LKML <linux-
> kernel@vger.kernel.org>; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v5 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> Support
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, 28 Oct 2025, Devendra K Verma wrote:
>
> > AMD MDB PCIe endpoint support. For AMD specific support added the
> > following
> >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> >   - AMD MDB specific driver data
> >   - AMD MDB specific VSEC capability to retrieve the device DDR
> >     base address.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v5:
> > Added the definitions for Xilinx specific VSEC header id, revision,
> > and register offsets.
> > Corrected the error type when no physical offset found for device side
> > memory.
> > Corrected the order of variables.
> >
> > Changes in v4:
> > Configured 8 read and 8 write channels for Xilinx vendor Added checks
> > to validate vendor ID for vendor specific vsec id.
> > Added Xilinx specific vendor id for vsec specific to Xilinx Added the
> > LL and data region offsets, size as input params to function
> > dw_edma_set_chan_region_offset().
> > Moved the LL and data region offsets assignment to function for Xilinx
> > specific case.
> > Corrected comments.
> >
> > Changes in v3:
> > Corrected a typo when assigning AMD (Xilinx) vsec id macro and
> > condition check.
> >
> > Changes in v2:
> > Reverted the devmem_phys_off type to u64.
> > Renamed the function appropriately to suit the functionality for
> > setting the LL & data region offsets.
> >
> > Changes in v1:
> > Removed the pci device id from pci_ids.h file.
> > Added the vendor id macro as per the suggested method.
> > Changed the type of the newly added devmem_phys_off variable.
> > Added to logic to assign offsets for LL and data region blocks in case
> > more number of channels are enabled than given in amd_mdb_data struct.
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 138
> > ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 136 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 3371e0a7..7b991a0 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -17,12 +17,27 @@
> >
> >  #include "dw-edma-core.h"
> >
> > +/* Synopsys */
> >  #define DW_PCIE_VSEC_DMA_ID                  0x6
> >  #define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> >  #define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> >  #define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> >  #define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
> >
> > +/* AMD MDB (Xilinx) specific defines */
> > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > +#define PCI_DEVICE_ID_AMD_MDB_B054           0xb054
> > +#define DW_PCIE_AMD_MDB_INVALID_ADDR         (~0ULL)
> > +#define DW_PCIE_XILINX_LL_OFF_GAP            0x200000
> > +#define DW_PCIE_XILINX_LL_SIZE                       0x800
> > +#define DW_PCIE_XILINX_DT_OFF_GAP            0x100000
> > +#define DW_PCIE_XILINX_DT_SIZE                       0x800
> > +#define DW_PCIE_XILINX_MDB_VSEC_HDR_ID               0x20
> > +#define DW_PCIE_XILINX_MDB_VSEC_REV          0x1
> > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH       0xc
> > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW        0x8
> > +
> >  #define DW_BLOCK(a, b, c) \
> >       { \
> >               .bar =3D a, \
> > @@ -50,6 +65,7 @@ struct dw_edma_pcie_data {
> >       u8                              irqs;
> >       u16                             wr_ch_cnt;
> >       u16                             rd_ch_cnt;
> > +     u64                             devmem_phys_off;
> >  };
> >
> >  static const struct dw_edma_pcie_data snps_edda_data =3D { @@ -90,6
> > +106,64 @@ struct dw_edma_pcie_data {
> >       .rd_ch_cnt                      =3D 2,
> >  };
> >
> > +static const struct dw_edma_pcie_data amd_mdb_data =3D {
> > +     /* MDB registers location */
> > +     .rg.bar                         =3D BAR_0,
> > +     .rg.off                         =3D 0x00001000,   /*  4 Kbytes */
> > +     .rg.sz                          =3D 0x00002000,   /*  8 Kbytes */
>
> Please use SZ_* + check that this file #includes correct header for them.
> You can then drop those comments.
>
> --
>  i.
>

Included the header file and used the appropriate macros instead of constan=
ts.

>
> > +
> > +     /* Other */
> > +     .mf                             =3D EDMA_MF_HDMA_NATIVE,
> > +     .irqs                           =3D 1,
> > +     .wr_ch_cnt                      =3D 8,
> > +     .rd_ch_cnt                      =3D 8,
> > +};
> > +
> > +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data
> *pdata,
> > +                                        enum pci_barno bar, off_t star=
t_off,
> > +                                        off_t ll_off_gap, size_t ll_si=
ze,
> > +                                        off_t dt_off_gap, size_t
> > +dt_size) {
> > +     u16 wr_ch =3D pdata->wr_ch_cnt;
> > +     u16 rd_ch =3D pdata->rd_ch_cnt;
> > +     off_t off;
> > +     u16 i;
> > +
> > +     off =3D start_off;
> > +
> > +     /* Write channel LL region */
> > +     for (i =3D 0; i < wr_ch; i++) {
> > +             pdata->ll_wr[i].bar =3D bar;
> > +             pdata->ll_wr[i].off =3D off;
> > +             pdata->ll_wr[i].sz =3D ll_size;
> > +             off +=3D ll_off_gap;
> > +     }
> > +
> > +     /* Read channel LL region */
> > +     for (i =3D 0; i < rd_ch; i++) {
> > +             pdata->ll_rd[i].bar =3D bar;
> > +             pdata->ll_rd[i].off =3D off;
> > +             pdata->ll_rd[i].sz =3D ll_size;
> > +             off +=3D ll_off_gap;
> > +     }
> > +
> > +     /* Write channel data region */
> > +     for (i =3D 0; i < wr_ch; i++) {
> > +             pdata->dt_wr[i].bar =3D bar;
> > +             pdata->dt_wr[i].off =3D off;
> > +             pdata->dt_wr[i].sz =3D dt_size;
> > +             off +=3D dt_off_gap;
> > +     }
> > +
> > +     /* Read channel data region */
> > +     for (i =3D 0; i < rd_ch; i++) {
> > +             pdata->dt_rd[i].bar =3D bar;
> > +             pdata->dt_rd[i].off =3D off;
> > +             pdata->dt_rd[i].sz =3D dt_size;
> > +             off +=3D dt_off_gap;
> > +     }
> > +}
> > +
> >  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int
> > nr)  {
> >       return pci_irq_vector(to_pci_dev(dev), nr); @@ -120,9 +194,24 @@
> > static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> >       u32 val, map;
> >       u16 vsec;
> >       u64 off;
> > +     int cap;
> >
> > -     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > -                                     DW_PCIE_VSEC_DMA_ID);
> > +     /*
> > +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> > +      * of map, channel counts, etc.
> > +      */
> > +     switch (pdev->vendor) {
> > +     case PCI_VENDOR_ID_SYNOPSYS:
> > +             cap =3D DW_PCIE_VSEC_DMA_ID;
> > +             break;
> > +     case PCI_VENDOR_ID_XILINX:
> > +             cap =3D DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, pdev->vendor, cap);
> >       if (!vsec)
> >               return;
> >
> > @@ -155,6 +244,28 @@ static void
> dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> >       off <<=3D 32;
> >       off |=3D val;
> >       pdata->rg.off =3D off;
> > +
> > +     /* Xilinx specific VSEC capability */
> > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> > +     if (!vsec)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > +     if (PCI_VNDR_HEADER_ID(val) !=3D DW_PCIE_XILINX_MDB_VSEC_HDR_ID
> ||
> > +         PCI_VNDR_HEADER_REV(val) !=3D DW_PCIE_XILINX_MDB_VSEC_REV)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev,
> > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HI=
GH,
> > +                           &val);
> > +     off =3D val;
> > +     pci_read_config_dword(pdev,
> > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LO=
W,
> > +                           &val);
> > +     off <<=3D 32;
> > +     off |=3D val;
> > +     pdata->devmem_phys_off =3D off;
> >  }
> >
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev, @@ -179,6 +290,7
> > @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       }
> >
> >       memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> > +     vsec_data->devmem_phys_off =3D DW_PCIE_AMD_MDB_INVALID_ADDR;
> >
> >       /*
> >        * Tries to find if exists a PCIe Vendor-Specific Extended
> > Capability @@ -186,6 +298,26 @@ static int dw_edma_pcie_probe(struct
> pci_dev *pdev,
> >        */
> >       dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> >
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> > +             /*
> > +              * There is no valid address found for the LL memory
> > +              * space on the device side.
> > +              */
> > +             if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_AMD_MDB_INVALID_ADDR)
> > +                     return -ENOMEM;
> > +
> > +             /*
> > +              * Configure the channel LL and data blocks if number of
> > +              * channels enabled in VSEC capability are more than the
> > +              * channels configured in amd_mdb_data.
> > +              */
> > +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > +                                            DW_PCIE_XILINX_LL_OFF_GAP,
> > +                                            DW_PCIE_XILINX_LL_SIZE,
> > +                                            DW_PCIE_XILINX_DT_OFF_GAP,
> > +                                            DW_PCIE_XILINX_DT_SIZE);
> > +     }
> > +
> >       /* Mapping PCI BAR regions */
> >       mask =3D BIT(vsec_data->rg.bar);
> >       for (i =3D 0; i < vsec_data->wr_ch_cnt; i++) { @@ -367,6 +499,8 @=
@
> > static void dw_edma_pcie_remove(struct pci_dev *pdev)
> >
> >  static const struct pci_device_id dw_edma_pcie_id_table[] =3D {
> >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> > +       (kernel_ulong_t)&amd_mdb_data },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> >

